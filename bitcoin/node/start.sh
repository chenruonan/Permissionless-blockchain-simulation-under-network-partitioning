#!/bin/bash

bitcoind -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf -daemon  -datadir=/usr/local/myproj/bitcoinLab/data

sleep 2s
        

# bitcoind 
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf createwallet mywallet

bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf -rpcwallet=mywallet getnewaddress mywallet > /usr/local/myproj/bitcoinLab/walletAddress.txt

