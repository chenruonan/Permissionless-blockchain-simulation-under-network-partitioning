#!/bin/bash
set -Eeuo pipefail

source ./vars.env

# Get options
while getopts "d:sh" flag; do
  case "${flag}" in
    d) DEBUG_LEVEL=${OPTARG};;
    s) SUBSCRIBE_ALL_SUBNETS="--subscribe-all-subnets";;
    h)
       echo "Start a geth node"
       echo
       echo "usage: $0 <Options> <DATADIR> <NETWORK-PORT> <HTTP-PORT>"
       echo
       echo "Options:"
       echo "   -h: this help"
       echo
       echo "Positional arguments:"
       echo "  DATADIR       Value for --datadir parameter"
       echo "  NETWORK-PORT  Value for --port"
       echo "  HTTP-PORT     Value for --http.port"
       echo "  AUTH-PORT     Value for --authrpc.port"
       echo "  GENESIS_FILE  Value for geth init"
       exit
       ;;
  esac
done

# Get positional arguments
data_dir=${@:$OPTIND+0:1}
network_port=${@:$OPTIND+1:1}
http_port=${@:$OPTIND+2:1}
auth_port=${@:$OPTIND+3:1}
genesis_file=${@:$OPTIND+4:1}
el_bootnode_ipaddress=${@:$OPTIND+5:1}
node_num=${@:$OPTIND+6:1}
el_bootnode_enr="enode://51ea9bb34d31efc3491a842ed13b8cab70e753af108526b57916d716978b380ed713f4336a80cdb85ec2a115d5a8c0ae9f3247bed3c84d3cb025c6bab311062c@$el_bootnode_ipaddress:0?discport=30301"
echo $data_dir
echo $network_port
echo $http_port
echo $auth_port
echo $genesis_file
echo $el_bootnode_ipaddress
echo $el_bootnode_enr
# Init
$GETH_BINARY init \
    --datadir $data_dir \
    $genesis_file
$GETH_BINARY --datadir $data_dir account import ../nodeSK/el_sk${node_num}.txt << EOF
1
1
EOF

echo "Completed init"
# eval "result=\"\${el_pk${node_num}}\""
exec $GETH_BINARY \
    --datadir $data_dir \
    --ipcdisable \
    --http \
    --http.api="engine,eth,web3,net,debug,admin,personal" \
    --networkid=$CHAIN_ID \
    --syncmode=full \
    --bootnodes $el_bootnode_enr \
    --port $network_port \
    --http.port $http_port \
    --authrpc.port $auth_port \
    --http.addr 0.0.0.0 \
    --http.vhosts 0.0.0.0 \
    --allow-insecure-unlock \
    --rpc.txfeecap 0 --rpc.gascap 0
    # --unlock=$result \
    # --password="" \
    # console \
