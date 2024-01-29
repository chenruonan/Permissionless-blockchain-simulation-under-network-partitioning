#!/usr/bin/env bash
# Start preparing processes necessary to create a local testnet

set -Eeuo pipefail

source ./vars.env
DATADIR=/usr/local/myproj/ethereumLab/setup/nodes
TESTNET_DIR=/usr/local/myproj/ethereumLab/setup
# Set a higher ulimit in case we want to import 1000s of validators.
ulimit -n 65536

# ./clean.sh

# VC_COUNT is defaulted in vars.env
DEBUG_LEVEL=${DEBUG_LEVEL:-info}
BUILDER_PROPOSALS=

# Get options. Handle all kinds of input from command line
while getopts "v:d:ph" flag; do
  case "${flag}" in
    v) VC_COUNT=${OPTARG};;
    d) DEBUG_LEVEL=${OPTARG};;
    p) BUILDER_PROPOSALS="-p";;
    h)
        validators=$(( $VALIDATOR_COUNT / $BN_COUNT ))
        echo "Start local testnet, defaults: 1 eth1 node, $BN_COUNT beacon nodes,"
        echo "and $VC_COUNT validator clients with each vc having $validators validators."
        echo
        echo "usage: $0 <Options>"
        echo
        echo "Options:"
        echo "   -v: VC_COUNT    default: $VC_COUNT"
        echo "   -d: DEBUG_LEVEL default: info"
        echo "   -p:             enable builder proposals"
        echo "   -h:             this help"
        exit
        ;;
  esac
done

if (( $VC_COUNT > $BN_COUNT )); then
    echo "Error $VC_COUNT is too large, must be <= BN_COUNT=$BN_COUNT"
    exit
fi

# Init some constants
LOG_DIR=/usr/local/myproj/ethereumLab/setup       # set the directory for putting the log files


# for (( bn=1; bn<=$BN_COUNT; bn++ )); do
#     touch $LOG_DIR/beacon_node_$bn.log
# done

# for (( el=1; el<=$BN_COUNT; el++ )); do
#     touch $LOG_DIR/geth_$el.log
# done

# for (( vc=1; vc<=$VC_COUNT; vc++ )); do
#     touch $LOG_DIR/validator_node_$vc.log
# done

NOW=`date +%s`
GENESIS_TIME=`expr $NOW + $GENESIS_DELAY`
# generate the genesis.ssz in the $TESTNET_DIR
echo $ETH1_BLOCK_HASH 
lcli \
	new-testnet \
	--spec $SPEC_PRESET \
	--deposit-contract-address $DEPOSIT_CONTRACT_ADDRESS \
	--testnet-dir $TESTNET_DIR \
	--min-genesis-active-validator-count $GENESIS_VALIDATOR_COUNT \
	--min-genesis-time $GENESIS_TIME \
	--genesis-delay $GENESIS_DELAY \
	--genesis-fork-version $GENESIS_FORK_VERSION \
	--altair-fork-epoch $ALTAIR_FORK_EPOCH \
	--bellatrix-fork-epoch $BELLATRIX_FORK_EPOCH \
	--capella-fork-epoch $CAPELLA_FORK_EPOCH \
	--ttd $TTD \
	--eth1-block-hash $ETH1_BLOCK_HASH \
	--eth1-id $CHAIN_ID \
	--eth1-follow-distance 1 \
	--seconds-per-slot $SECONDS_PER_SLOT \
	--seconds-per-eth1-block $SECONDS_PER_ETH1_BLOCK \
	--proposer-score-boost "$PROPOSER_SCORE_BOOST" \
	--validator-count $GENESIS_VALIDATOR_COUNT \
	--interop-genesis-state \
	--force >> $LOG_DIR/setup.log 2>&1

echo "Specification and genesis.ssz generated at $TESTNET_DIR." >> $LOG_DIR/setup.log 2>&1
echo "Generating $VALIDATOR_COUNT validators concurrently... (this may take a while)" >> $LOG_DIR/setup.log 2>&1
# generate the validator msg in node directory from node_1 to node_$BN_COUNT
lcli \
	insecure-validators \
	--count $VALIDATOR_COUNT \
	--base-dir $DATADIR \
	--node-count $BN_COUNT >> $LOG_DIR/setup.log 2>&1

# echo Validators generated with keystore passwords at $DATADIR.
