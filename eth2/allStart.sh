#!/bin/bash

ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethereumLab/ips.txt))

bootnodeIP=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
enr="-MS4QNZnCtcrWwFFOB26WfnMOeE1T0qMEBfDRJM6PUAvz48EOhfyWYcXtReYRP3EOvKiLMSKR5R3-DMAFaKHWWm6wy8Bh2F0dG5ldHOIAAAAAAAAAACEZXRoMpCq8mMKQkJCQv__________gmlkgnY0gmlwhMCoAAGJc2VjcDI1NmsxoQONXIcg-AhGmfIUHs2cPqSA08d1Ixf87IPXglrY0p71KIhzeW5jbmV0cwCDdGNwgiMohHRjcDaCEJKDdWRwghCS"
cnt=1
for ip in "${ip_list[@]}"; do
    ssh root@$ip "export CNT=$cnt; export BOOTNODEIP=$bootnodeIP;export ENR=$enr; bash -s" < /usr/local/myproj/ethereumLab/start.sh &
    ((cnt++))
done

wait