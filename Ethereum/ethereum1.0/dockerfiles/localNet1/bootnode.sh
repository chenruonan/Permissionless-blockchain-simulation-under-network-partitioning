#!/usr/bin/env bash

#
# Generates a bootnode enr and saves it in $TESTNET/boot_enr.yaml
# Starts a bootnode from the generated enr.
#

set -Eeuo pipefail

source ./vars.env

echo "Generating bootnode enr"
# generate an enr address to be used as a pre-genesis boot node
lcli \
	generate-bootnode-enr \
	--ip 192.168.0.100 \
	--udp-port $BOOTNODE_PORT \
	--tcp-port $BOOTNODE_PORT \
	--genesis-fork-version $GENESIS_FORK_VERSION \
	--output-dir $DATADIR/bootnode

bootnode_enr=`cat $DATADIR/bootnode/enr.dat`
echo "- $bootnode_enr" > $TESTNET_DIR/boot_enr.yaml

echo "Generated bootnode enr and written to $TESTNET_DIR/boot_enr.yaml"

DEBUG_LEVEL=${1:-info}

echo "Starting bootnode"
# used for beacon node to find each other
exec lighthouse boot_node \
    --testnet-dir $TESTNET_DIR \
    --port $BOOTNODE_PORT \
    --listen-address 192.168.0.100 \
	--disable-packet-filter \
    --network-dir $DATADIR/bootnode \
