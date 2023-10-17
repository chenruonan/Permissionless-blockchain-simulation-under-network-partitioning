#!/bin/sh
bitcoind -conf=/usr/local/etc/bitcoin/bitcoin.conf -daemon -datadir=/usr/local/etc/bitcoin/data -addnode=172.17.0.5 -addnode=172.17.0.3
