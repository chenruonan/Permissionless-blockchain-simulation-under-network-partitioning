#!/bin/bash

# 启动时通过环境变量传入节点编号,el_bootnode_ipaddress
GETH_BINARY=/usr/local/myproj/ethpowLab/bin/geth
mkdir -p /usr/local/myproj/ethpowLab/datadir_${NODE_NUM}

EL_base_network=7000
EL_base_http=6000
EL_base_auth_http=5000


el_bootnode_enr="enode://51ea9bb34d31efc3491a842ed13b8cab70e753af108526b57916d716978b380ed713f4336a80cdb85ec2a115d5a8c0ae9f3247bed3c84d3cb025c6bab311062c@$BOOTNODEIP:0?discport=30301"
# el_bootnode_enr="enode://51ea9bb34d31efc3491a842ed13b8cab70e753af108526b57916d716978b380ed713f4336a80cdb85ec2a115d5a8c0ae9f3247bed3c84d3cb025c6bab311062c@192.168.0.1:0?discport=30301"

# 初始化目录
$GETH_BINARY init --datadir /usr/local/myproj/ethpowLab/datadir_${NODE_NUM} /usr/local/myproj/ethpowLab/genesis.json 

#
$GETH_BINARY --datadir /usr/local/myproj/ethpowLab/datadir_${NODE_NUM} account import /usr/local/myproj/ethpowLab/nodeSK/el_sk${NODE_NUM}.txt << EOF
1
1
EOF

echo "completed init in datadir"

$GETH_BINARY --datadir /usr/local/myproj/ethpowLab/datadir_${NODE_NUM} \
     --ipcdisable \
     --http \
     --http.api="engine,eth,web3,net,debug,admin,personal" \
     --networkid=4242 \
     --syncmode=full \
     --bootnodes $el_bootnode_enr \
     --port $EL_base_network \
     --http.port $EL_base_http \
     --http.addr 0.0.0.0 \
     --http.vhosts 0.0.0.0 \
     --mine \
     --miner.threads 2 \
     --allow-insecure-unlock \
     --rpc.txfeecap 0 \
     --rpc.gascap 0 \