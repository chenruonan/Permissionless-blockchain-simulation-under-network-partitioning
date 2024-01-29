#!/usr/bin/env bash
# 检查是否提供了IP地址作为参数
if [ $# -eq 0 ]; then
    echo "请提供一个IP地址作为参数"
    exit 1
fi

# 获取第一个参数（即传递给脚本的IP地址）
ip_address="$1"
priv_key="02fd74636e96a8ffac8e7b01b0de8dea94d6bcf4989513b38cf59eb32163ff91"
bootnode -addr $ip_address:30301 --nodekeyhex $priv_key