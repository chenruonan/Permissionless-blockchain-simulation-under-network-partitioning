#!/bin/bash

network_interface="eth0"

myip=$(ip addr show $network_interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# 清除日志
rm /usr/local/myproj/ethereumLab/node/logs/*.log

# 清除网络流量控制规则
tc qdisc del dev "$network_interface" root 2>/dev/null

echo "removed logs and tc rules in $myip"