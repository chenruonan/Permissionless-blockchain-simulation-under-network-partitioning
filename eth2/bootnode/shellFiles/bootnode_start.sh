#!/usr/bin/env bash
# start the bootnode. no input is needed.
set -Eeuo pipefail

source ./vars.env
LOG_DIR=$TESTNET_DIR


# 检查是否提供了IP地址作为参数
if [ $# -eq 0 ]; then
    echo "请提供一个IP地址作为参数"
    exit 1
fi

# 获取第一个参数（即传递给脚本的IP地址）
ip_address="$1"

# Sleep with a message
sleeping() {
   echo sleeping $1
   sleep $1
}


# Execute the command with logs saved to a file.
#
# First parameter is log file name
# Second parameter is executable name
# Remaining parameters are passed to executable
execute_command() {
    LOG_NAME=$1
    EX_NAME=$2
    shift
    shift
    touch $LOG_DIR/$LOG_NAME
    CMD="$EX_NAME $@ >> $LOG_DIR/$LOG_NAME 2>&1"
    echo "executing: $CMD"
    echo "$CMD" > "$LOG_DIR/$LOG_NAME"
    eval "$CMD &"
}

# Execute the command with logs saved to a file
# and is PID is saved to $PID_FILE.
#
# First parameter is log file name
# Second parameter is executable name
# Remaining parameters are passed to executable
# execute_command_add_PID() {
#     execute_command $@
#     echo "$!" >> $PID_FILE
# }


# Delay to let boot_enr.yaml to be created 启动bootnode
execute_command bootnode.log ./bootnode.sh $ip_address
sleeping 1

execute_command el_bootnode.log ./el_bootnode.sh $ip_address
sleeping 1


while true; do
  sleep 50  
done










