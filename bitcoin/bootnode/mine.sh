#!/bin/bash
echo $$ > /usr/local/myproj/bitcoinLab/minePid.txt
while true
do
    echo "192.168.1.1 mined a block"
    ssh root@192.168.1.1 "/usr/local/myproj/bitcoinLab/genBlock.sh" &
    sleep 60
    # echo "192.168.2.1 mined a block"
    # ssh root@192.168.2.1 "/usr/local/myproj/bitcoinLab/genBlock.sh" &
    # sleep 60
done

wait