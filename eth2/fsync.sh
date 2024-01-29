#!/bin/bash

ip_list=($(grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" /usr/local/myproj/ethereumLab/ips.txt))

/usr/local/myproj/ethereumLab/node/shellFiles/reset_genesis_time.sh
# rsync文件到follower

log_source_directory="/usr/local/myproj/ethereumLab/node/logs"
shell_source_directory="/usr/local/myproj/ethereumLab/node/shellFiles"
log_target_directory="/usr/local/myproj/ethereumLab/node/"
shell_target_directory="/usr/local/myproj/ethereumLab/node/"
docker_source_file="/usr/local/myproj/ethereumLab/node/docker_node_start.sh"
docker_target_file="/usr/local/myproj/ethereumLab/node/"
start_source_file="/usr/local/myproj/ethereumLab/start.sh"
start_target_file="/usr/local/myproj/ethereumLab/node"
down_source_file="/usr/local/myproj/ethereumLab/down.sh"
down_target_file="/usr/local/myproj/ethereumLab/node"
clean_source_file="/usr/local/myproj/ethereumLab/cleanLogs.sh"
clean_target_file="/usr/local/myproj/ethereumLab/node"
setBandwidth_source_file="/usr/local/myproj/ethereumLab/setBandwidth.sh"
setBandwidth_target_file="/usr/local/myproj/ethereumLab/node"

for ip in "${ip_list[@]}"; do
    rsync -avz "$log_source_directory" "root@$ip:$log_target_directory" &
    rsync -avz "$shell_source_directory" "root@$ip:$shell_target_directory" &
    rsync -avz "$docker_source_file" "root@$ip:$docker_target_file" &
    rsync -avz "$start_source_file" "root@$ip:$start_target_file" &
    rsync -avz "$down_source_file" "root@$ip:$down_target_file" &
    rsync -avz "$clean_source_file" "root@$ip:$clean_target_file" &
    rsync -avz "$setBandwidth_source_file" "root@$ip:$setBandwidth_target_file" &
done

wait
