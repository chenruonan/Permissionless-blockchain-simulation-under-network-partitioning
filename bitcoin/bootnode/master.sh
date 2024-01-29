#!/bin/bash

#ssh到远程主机执行对应脚本命令

read -p "Enter command: " command

case "$command" in
   ssh)
    echo "install the ssh key in all the server"
    /usr/local/myproj/bitcoinLab/sshReset.sh
    /usr/local/myproj/bitcoinLab/sshKeyInstall.exp
    ;;
  bandwidth)
    echo "Executing setting bandwidth in all the server..."
    # 
    /usr/local/myproj/bitcoinLab/bandwidth.sh
    ;;
  start)
    echo "Executing starting bitcoin node in all the server..."
    # 
    /usr/local/myproj/bitcoinLab/allStart.sh
    ;;
  down)
    echo "Executing stopping bitcoin node in all the server..."
    # 
    /usr/local/myproj/bitcoinLab/allDown.sh
    ;;
  conn)
    echo "connecting nodes to each other "
    /usr/local/myproj/bitcoinLab/allConn.sh
    ;;
  init)
    echo "init blocks to all nodes"
    /usr/local/myproj/bitcoinLab/allInit.sh
    ;;
  *)
    echo "Invalid command."
    ;;
esac
























