#!/bin/bash
while :
do
    ./getbalance.sh
    ./gettxoutsetinfo.sh
    sleep 5
done
