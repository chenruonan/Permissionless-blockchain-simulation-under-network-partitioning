#!/usr/bin/env bash

#
# Generates a bootnode enr and saves it in $TESTNET/boot_enr.yaml
# Starts a bootnode from the generated enr.
#

set -Eeuo pipefail

source ./vars.env

# 检查是否提供了IP地址作为参数
if [ $# -eq 0 ]; then
    echo "请提供一个IP地址作为参数"
    exit 1
fi

# 获取第一个参数（即传递给脚本的IP地址）
ip_address="$1"

echo "Generating bootnode enr"
# generate an enr address to be used as a pre-genesis boot node
lcli \
	generate-bootnode-enr \
	--ip $ip_address \
	--udp-port $BOOTNODE_PORT \
	--tcp-port $BOOTNODE_PORT \
	--genesis-fork-version $GENESIS_FORK_VERSION \
	--output-dir $DATADIR/network

bootnode_enr=`cat $DATADIR/network/enr.dat`
echo "- $bootnode_enr" > $DATADIR/network/boot_enr.yaml

echo "Generated bootnode enr and written to $DATADIR/network/boot_enr.yaml"

DEBUG_LEVEL=${1:-info}

echo "Starting bootnode"
# used for beacon node to find each other
exec lighthouse boot_node \
    --testnet-dir $TESTNET_DIR \
    --port $BOOTNODE_PORT \
    --listen-address $ip_address \
	--disable-packet-filter \
    --network-dir $DATADIR/network \
