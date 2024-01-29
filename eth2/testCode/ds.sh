#!/bin/bash

for ((i=1; i<=45; i++)); do
    echo "started-----------------------------------------"

    /usr/local/myproj/ethereumLab/master.sh << EOF
    down
EOF

    /usr/local/myproj/ethereumLab/master.sh << EOF
    clean
EOF


    # 启动bootnode修改bootnode信息
    docker stop $(docker ps -aq);docker rm $(docker ps -aq)
    /usr/local/myproj/ethereumLab/bootnode/docker_bootnode_start.sh 192.168.0.1
    sleep 2
    enr_value=$(grep 'enr:' /usr/local/myproj/ethereumLab/bootnode/logs/bootnode.log | awk '{sub(/enr:/, ""); print $NF}')
    enr_value_cleaned=$(echo "$enr_value" | awk '{gsub(/^enr:|}$/, ""); print}')
    echo $enr_value_cleaned
    sed -i "s/enr=\"[^\"]*\"/enr=\"$enr_value_cleaned\"/g" /usr/local/myproj/ethereumLab/allStart.sh


    # fsync
    /usr/local/myproj/ethereumLab/master.sh << EOF
    fsync
EOF

    /usr/local/myproj/ethereumLab/master.sh << EOF
    start
EOF

    sleep 3

    python3 /usr/local/myproj/ethereumLab/testCode/connAndUnlock.py

    echo "completed------------------------------------------"


done


/usr/local/myproj/ethereumLab/master.sh << EOF
    down
EOF

    /usr/local/myproj/ethereumLab/master.sh << EOF
    clean
EOF


# 启动bootnode修改bootnode信息
docker stop $(docker ps -aq);docker rm $(docker ps -aq)



