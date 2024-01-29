#!/bin/bash


# Set the network interface (change this to match your environment)
network_interface="eth0"

# Delete existing traffic control configurations
# tc qdisc del dev "$network_interface" root 2>/dev/null

# Add a new htb root qdisc for egress
tc qdisc show dev "$network_interface" | grep -q "htb" || tc qdisc add dev "$network_interface" root handle 1: htb default 10
# tc qdisc add dev "$network_interface" root handle 1: htb default 10

# Add a class for overall rate limiting
tc class add dev "$network_interface" parent 1: classid 1:$CNT htb rate "$SPEED"

# Add a filter to classify traffic based on source and destination IP for egress
tc filter add dev "$network_interface" parent 1: protocol ip prio 1 u32 match ip src "$IPSRC" match ip dst "$IPDST" flowid 1:$CNT

echo "Traffic from $IPSRC to $IPDST limited to $SPEED"

#tc -s qdisc show dev ens33