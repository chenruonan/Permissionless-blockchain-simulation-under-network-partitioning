#!/bin/bash

# ssh到follower并初始化目录 安装docker
ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethereumLab/ips.txt))

initC() {
    echo "Initializing on $1"
    ssh root@$1 "mkdir -p /usr/local/myproj/ethereumLab/node" 
}

for ip in "${ip_list[@]}"; do
    initC "$ip" &
done
wait






















