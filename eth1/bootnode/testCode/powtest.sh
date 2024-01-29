#!/bin/bash

for ((i=1; i<=50; i++)); do
    echo "started-----------------------------------------"

    /usr/local/myproj/ethpowLab/master.sh << EOF
    down
EOF

    # 启动elbootnode和节点
    sleep 1
    /usr/local/myproj/ethpowLab/master.sh << EOF
    start
EOF

    sleep 3

    python3 /usr/local/myproj/ethpowLab/testCode/powtest.py

    echo "completed------------------------------------------"


done


/usr/local/myproj/ethpowLab/master.sh << EOF
    down
EOF




