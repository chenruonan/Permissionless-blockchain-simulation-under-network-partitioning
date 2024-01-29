#!/bin/bash

bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf stop
rm -r /usr/local/myproj/bitcoinLab/data/*
rm /usr/local/myproj/bitcoinLab/height.txt
kill -9 $(cat /usr/local/myproj/bitcoinLab/pid.txt)
