#!/bin/sh
bitcoin-cli -conf=/usr/local/etc/bitcoin/bitcoin.conf createwallet testwallet1
bitcoin-cli -conf=/usr/local/etc/bitcoin/bitcoin.conf -rpcwallet=testwallet1 getnewaddress testwallet1

