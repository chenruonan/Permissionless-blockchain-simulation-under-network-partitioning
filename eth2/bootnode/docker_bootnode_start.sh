#!/bin/bash
# one parameter: the ip addr of the bootnode

# 启动 Docker 容器并传递参数 hostname -I | awk '{print $1}'
# docker run -v /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/bootnode.log:/usr/local/myproj/ethereumTest/localNet1/testnet/bootnode.log \
#             -v /usr/local/myproj/ethereumTest/localNet1_docker/dockerfiles/localNet1/testnet/el_bootnode.log:/usr/local/myproj/ethereumTest/localNet1/testnet/el_bootnode.log \
docker run -v  /usr/local/myproj/ethereumLab/bootnode/logs:/usr/local/ethereumLab/bootnode/logs  --name bootnodes --network host -dit youngzer541/bootnode:latestV2 $1