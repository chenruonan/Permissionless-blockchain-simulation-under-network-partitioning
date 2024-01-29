#!/bin/bash

#
# Resets the beacon state genesis time to now.
#

set -Eeuo pipefail


NOW=$(date +%s)

lcli \
	change-genesis-time -d  /usr/local/myproj/ethereumLab/node/shellFiles\
	/usr/local/myproj/ethereumLab/node/shellFiles/genesis.ssz \
	$(date +%s)
cp /usr/local/myproj/ethereumLab/node/shellFiles/genesis.ssz /usr/local/myproj/ethereumLab/node/logs/genesis.ssz
echo "Reset genesis time to now ($NOW)"
