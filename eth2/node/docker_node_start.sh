#!/bin/bash

#parameters: node_num el_bootnode_address ipaddress bootnode_enr 
# 检查是否提供了参数
if [ $# -eq 0 ]; then
    echo "Usage: $0 <parameter>"
    exit 1
fi
echo $1 
echo $2
echo $3
echo $4
# echo "">/usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/geth_$1.log
# echo "">/usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/beacon_node_$1.log
# echo "">/usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/validator_node_$1.log
# 启动 Docker 容器并传递参数
# docker run -v /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/geth_$1.log:/usr/local/myproj/ethereumTest/localNet1/testnet/geth_$1.log \
#         -v /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/beacon_node_$1.log:/usr/local/myproj/ethereumTest/localNet1/testnet/beacon_node_$1.log \
#         -v /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/validator_node_$1.log:/usr/local/myproj/ethereumTest/localNet1/testnet/validator_node_$1.log \
docker run -v /usr/local/myproj/ethereumLab/node/logs:/usr/local/ethereumLab/node/logs \
           -v /usr/local/myproj/ethereumLab/node/shellFiles:/usr/local/ethereumLab/node/shellFiles \
            --name node_$1 --network host -dit youngzer541/node:latestV2 -n $1 -e $2 -i $3 -b $4 genesis.json 