#!/bin/sh

while :
do
    balance=$(bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf -rpcwallet=mywallet getbalance)
    echo "余额为：$balance,pid:$$"
    sleep 1
done
