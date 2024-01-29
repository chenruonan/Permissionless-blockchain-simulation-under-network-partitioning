#!/bin/bash

/usr/local/myproj/ethpowLab/elbootnode/down.sh

ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethpowLab/ips.txt))
cnt=1
for ip in "${ip_list[@]}"; do
    ssh root@$ip "export NODE_NUM=$cnt;/usr/local/myproj/ethpowLab/down.sh" &
    ((cnt++))
done

wait