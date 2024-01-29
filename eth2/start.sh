#!/bin/bash

myip=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
/usr/local/myproj/ethereumLab/node/docker_node_start.sh $CNT $BOOTNODEIP $myip $ENR