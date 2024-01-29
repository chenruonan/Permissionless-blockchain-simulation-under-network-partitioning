#!/bin/bash

network_interface="eth0"


# 清除网络流量控制规则
tc qdisc del dev "$network_interface" root 2>/dev/null
