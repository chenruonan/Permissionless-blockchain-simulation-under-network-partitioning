#!/bin/bash

#ssh到远程主机执行对应脚本命令

read -p "Enter command: " command

case "$command" in
   ssh)
    echo "install the ssh key in all the server"
    /usr/local/myproj/ethereumLab/sshReset.sh
    /usr/local/myproj/ethereumLab/sshKeyInstall.exp
    ;;
  init)
    echo "Executing init directories in all the server..."
    # 
    /usr/local/myproj/ethereumLab/init.sh
    ;;
  fsync)
    echo "Executing syncing files that are needed to be mounted in all the server..."
    # 
    /usr/local/myproj/ethereumLab/fsync.sh
    ;;
  bandwidth)
    echo "Executing setting bandwidth in all the server..."
    # 
    /usr/local/myproj/ethereumLab/bandwidth.sh
    ;;
  start)
    echo "Executing starting docker containers in all the server..."
    # 
    /usr/local/myproj/ethereumLab/allStart.sh
    ;;
  down)
    echo "Executing stopping docker containers in all the server..."
    # 
    /usr/local/myproj/ethereumLab/allDown.sh
    ;;
  clean)
    echo "Executing cleanning in all the server..."
    #
    /usr/local/myproj/ethereumLab/allClean.sh
    ;;
  *)
    echo "Invalid command."
    ;;
esac
























