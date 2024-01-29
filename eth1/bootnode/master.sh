#!/bin/bash

#ssh到远程主机执行对应脚本命令

read -p "Enter command: " command

case "$command" in
   ssh)
    echo "install the ssh key in all the server"
    /usr/local/myproj/ethpowLab/sshReset.sh
    /usr/local/myproj/ethpowLab/sshKeyInstall.exp
    ;;
  bandwidth)
    echo "Executing setting bandwidth in all the server..."
    # 
    /usr/local/myproj/ethpowLab/bandwidth.sh
    ;;
  start)
    echo "Executing starting all geth nodes in all the server..."
    # 
    /usr/local/myproj/ethpowLab/allStart.sh
    ;;
  down)
    echo "Executing stopping all geth nodes in all the server..."
    # 
    /usr/local/myproj/ethpowLab/allDown.sh
    ;;
  *)
    echo "Invalid command."
    ;;
esac
























