#!/bin/bash

ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/bitcoinLab/ips.txt))

for ip in "${ip_list[@]}"; do
    ssh root@$ip "/usr/local/myproj/bitcoinLab/start.sh" &
done

wait