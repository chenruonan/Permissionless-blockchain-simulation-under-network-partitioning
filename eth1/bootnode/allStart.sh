#!/bin/bash

# 启动bootnode
/usr/local/myproj/ethpowLab/elbootnode/start.sh
sleep 2


ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethpowLab/ips.txt))

bootnodeIP=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
cnt=1
for ip in "${ip_list[@]}"; do
    ssh root@$ip "export NODE_NUM=$cnt; export BOOTNODEIP=$bootnodeIP;echo "" >/usr/local/myproj/ethpowLab/logs.log; /usr/local/myproj/ethpowLab/start.sh > /usr/local/myproj/ethpowLab/logs.log 2>&1 &"   &
    ((cnt++))
done

wait