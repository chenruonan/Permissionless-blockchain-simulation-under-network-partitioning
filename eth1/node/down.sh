#!/bin/bash

pkill -f geth
sleep 1
rm -rf /usr/local/myproj/ethpowLab/datadir_${NODE_NUM}

network_interface="eth0"
#清除网络流量控制规则
tc qdisc del dev "$network_interface" root 2>/dev/null

echo "geth datadir and traffic control rules removed..."


