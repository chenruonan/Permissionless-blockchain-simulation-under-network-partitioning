#!/bin/bash

#
# Resets the beacon state genesis time to now.
#

set -Eeuo pipefail

source ./vars.env

NOW=$(date +%s)

lcli \
	change-genesis-time -d  /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet\
	/usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/genesis.ssz \
	$(date +%s)

echo "Reset genesis time to now ($NOW)"
