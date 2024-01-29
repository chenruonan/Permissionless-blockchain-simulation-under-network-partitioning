#!/bin/bash

echo $$ > /usr/local/myproj/bitcoinLab/pid.txt
test_address=$(bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf getnewaddress)

while true
do
    bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf sendtoaddress $test_address 0.01
    sleep 1
done

