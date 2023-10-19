#!/usr/bin/env bash
# create the geth client、beacon node and validator client process for one node
# input: node_num, el_bootnode_address, ipaddress, bootnode_enr, genesis_file
set -Eeuo pipefail

source ./vars.env
PID_FILE=$TESTNET_DIR/PIDS.pid
LOG_DIR=$TESTNET_DIR
# Set a higher ulimit in case we want to import 1000s of validators.
ulimit -n 65536

# VC_COUNT is defaulted in vars.env
DEBUG_LEVEL=${DEBUG_LEVEL:-info}
BUILDER_PROPOSALS=

while getopts "n:e:i:b:" flag; do
  case "${flag}" in
    n) node_num=${OPTARG}
      echo $node_num
    ;;
    e) el_bootnode_address=${OPTARG}
      echo $el_bootnode_address
        ;;
    i) ipaddress=${OPTARG}
      echo $ipaddress
    ;;
    b) bootnode_enr=${OPTARG}
      echo $bootnode_enr
    ;;
  esac
done

# 获取未解析的参数（genesis.json 文件）
shift $((OPTIND-1))
if [ $# -gt 0 ]; then
  genesis_file="$1" # should be genesis.json
fi

# Sleep with a message
sleeping() {
   echo sleeping $1
   sleep $1
}

# Execute the command with logs saved to a file.
#
# First parameter is log file name
# Second parameter is executable name
# Remaining parameters are passed to executable
execute_command() {
    LOG_NAME=$1
    EX_NAME=$2
    shift
    shift
    CMD="$EX_NAME $@ >> $LOG_DIR/$LOG_NAME 2>&1"
    echo "executing: $CMD"
    echo "$CMD" > "$LOG_DIR/$LOG_NAME"
    eval "$CMD &"
}

# Execute the command with logs saved to a file
# and is PID is saved to $PID_FILE.
#
# First parameter is log file name
# Second parameter is executable name
# Remaining parameters are passed to executable
execute_command_add_PID() {
    execute_command $@
    echo "$!" >> $PID_FILE
}

GENESIS_TIME=$(lcli pretty-ssz --testnet-dir $TESTNET_DIR BeaconState $TESTNET_DIR/genesis.ssz | jq | grep -Po 'genesis_time": "\K.*\d')
echo $GENESIS_TIME
CAPELLA_TIME=$((GENESIS_TIME + (CAPELLA_FORK_EPOCH * 32 * SECONDS_PER_SLOT)))
echo $CAPELLA_TIME
sed -i 's/"shanghaiTime".*$/"shanghaiTime": '"$CAPELLA_TIME"',/g' $genesis_file
# cat $genesis_file

# Start beacon nodes
BN_udp_tcp_base=9000
BN_http_port_base=8000

EL_base_network=7000
EL_base_http=6000
EL_base_auth_http=5000

# start the execution layer for $node_num
execute_command_add_PID geth_$node_num.log ./geth.sh $DATADIR/geth_datadir$node_num $((EL_base_network + $node_num)) $((EL_base_http + $node_num)) $((EL_base_auth_http + $node_num)) $genesis_file $el_bootnode_address $node_num
sleeping 20

#start the beacon node for $node_num(we take vc_count equals to bn_count by default so SAS is the empty string)
  # Reset the `genesis.json` config file fork times.
sed -i 's/"shanghaiTime".*$/"shanghaiTime": 0,/g' $genesis_file
(( $VC_COUNT < $BN_COUNT )) && SAS=-s || SAS=
secret=$DATADIR/geth_datadir$node_num/geth/jwtsecret
execute_command_add_PID beacon_node_$node_num.log ./beacon_node.sh $SAS -d $DEBUG_LEVEL $DATADIR/node_$node_num $((BN_udp_tcp_base + $node_num)) $((BN_http_port_base + $node_num)) http://localhost:$((EL_base_auth_http + $node_num)) $secret $ipaddress $bootnode_enr

#start requested number of validator clients
execute_command_add_PID validator_node_$node_num.log ./validator_client.sh $BUILDER_PROPOSALS -d $DEBUG_LEVEL $DATADIR/node_$node_num http://localhost:$((BN_http_port_base + $node_num))

echo "$node_num geth、beacon、validator started!"

while true; do
  sleep 50  
done