#!/bin/bash

# 47-16
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.1.1:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.1.2:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.1.3:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.1.4:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.2.1:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.2.2:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.2.3:8001" "add"
bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  addnode "192.168.3.1:8001" "add"





sleep 20

bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf  getpeerinfo


