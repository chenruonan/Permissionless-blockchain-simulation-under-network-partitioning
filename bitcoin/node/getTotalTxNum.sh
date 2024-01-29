#!/bin/bash

best_block_height=$(bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf getblockcount)

if [ -f /usr/local/myproj/bitcoinLab/height.txt ];then
    initialHeight=$(cat /usr/local/myproj/bitcoinLab/height.txt)
else
    echo $best_block_height > /usr/local/myproj/bitcoinLab/height.txt
    initialHeight=$best_block_height
fi
# 获取当前链上的最新区块高度

# 初始化交易总数
total_transactions=0

# 遍历每一个区块，累积交易总数
for ((block_height=initialHeight; block_height<=$best_block_height; block_height++)); do
    block_hash=$(bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf getblockhash $block_height)
    block_info=$(bitcoin-cli -conf=/usr/local/myproj/bitcoinLab/bitcoin.conf getblock $block_hash)
    transactions=$(echo "$block_info" | jq '.tx | length')
    
    total_transactions=$((total_transactions + transactions))
done

echo "`date` 链上交易总数：$total_transactions"
