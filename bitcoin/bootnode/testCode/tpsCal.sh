#!/bin/bash

#TODO 将所有脚本写在一起
# 启动
# /usr/local/myproj/bitcoinLab/master.sh << EOF
# start
# EOF
# # 节点连接
# sleep 10
# /usr/local/myproj/bitcoinLab/master.sh << EOF
# conn
# EOF
# sleep 15
# # 初始化
# /usr/local/myproj/bitcoinLab/master.sh << EOF
# init
# EOF
# 挖矿
/usr/local/myproj/bitcoinLab/mine.sh &



ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/bitcoinLab/ips.txt))
# 获取列表长度
# 调整带宽
/usr/local/myproj/bitcoinLab/testCode/adjustBandwidth.sh
# 注入交易
ssh root@192.168.1.1 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.1.2 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.1.3 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.1.4 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.1.5 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.2.1 "/usr/local/myproj/bitcoinLab/sendTx.sh" &
ssh root@192.168.2.2 "/usr/local/myproj/bitcoinLab/sendTx.sh" &


# 返回上链交易量 分别从192.168.1.1和192.168.2.1返回
# 每60秒做一次 

echo "" > mainTps.txt
echo "" > subTps.txt
while true
do
    ssh root@192.168.1.1 "/usr/local/myproj/bitcoinLab/getTotalTxNum.sh" >> mainTps.txt & 
    ssh root@192.168.2.1 "/usr/local/myproj/bitcoinLab/getTotalTxNum.sh" >> subTps.txt & 
    sleep 60
done





