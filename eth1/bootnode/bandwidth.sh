#!/bin/bash

# 限制CIDR1中的主机与CIDR2中的主机之间的带宽为SPEED
read -p "Enter number: " cnt
read -p "Enter CIDR1: " CIDR1
read -p "Enter CIDR2: " CIDR2
# kbps(千字节秒) mbps kbit mbit bps(字节秒)
read -p "Enter speed(xxx mbps kbit mbit bps): " SPEED

# Function to check if an IP address is in a subnet
ip_in_subnet() {
    IP=$1
    MASK=$2
    min=`/usr/bin/ipcalc $MASK|awk '/HostMin:/{print $2}'`
    max=`/usr/bin/ipcalc $MASK|awk '/HostMax:/{print $2}'`
    MIN=`echo $min|awk -F"." '{printf"%.0f\n",$1*256*256*256+$2*256*256+$3*256+$4}'`
    MAX=`echo $max|awk -F"." '{printf"%.0f\n",$1*256*256*256+$2*256*256+$3*256+$4}'`
    IPvalue=`echo $IP|awk -F"." '{printf"%.0f\n",$1*256*256*256+$2*256*256+$3*256+$4}'`
    [ "$IPvalue" -ge "$MIN" ] && [ "$IPvalue" -le "$MAX" ]
}

# 从 ips.txt 文件中提取 IP 地址列表
ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethpowLab/ips.txt))

# 循环处理每个 IP 地址 对在网段1中的主机设置其与网段2中的主机之间的带宽限制
for ip in "${ip_list[@]}"; do
    if ip_in_subnet "$ip" "$CIDR1";then
    # 限制上传带宽
    ssh root@$ip "export CNT=$cnt;export IPSRC=$ip; export IPDST=$CIDR2;export SPEED=$SPEED; bash -s" < /usr/local/myproj/ethpowLab/setBandwidth.sh &
    echo "$ip is in $CIDR1"
    elif ip_in_subnet "$ip" "$CIDR2";then
    # 限制上传带宽
    ssh root@$ip "export CNT=$cnt;export IPSRC=$ip; export IPDST=$CIDR1;export SPEED=$SPEED; bash -s" < /usr/local/myproj/ethpowLab/setBandwidth.sh &
    echo "$ip is in $CIDR2"
    fi
done

# 等待所有 SSH 进程执行完毕
wait

echo "Bandwidth configuration completed."
