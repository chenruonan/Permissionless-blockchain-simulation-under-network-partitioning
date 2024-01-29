#!/bin/bash

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


execute_command /usr/local/myproj/ethpowLab/elbootnode/el_bootnode.log /usr/local/myproj/ethpowLab/elbootnode/el_bootnode.sh 192.168.0.1

