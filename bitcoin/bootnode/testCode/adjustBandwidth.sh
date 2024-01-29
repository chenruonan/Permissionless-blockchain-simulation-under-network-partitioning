#!/bin/bash

/usr/local/myproj/bitcoinLab/master.sh << EOF
bandwidth
1
192.168.1.0/24
192.168.2.0/24
8bps
EOF

/usr/local/myproj/bitcoinLab/master.sh << EOF
bandwidth
2
192.168.1.0/24
192.168.3.0/24
1024kbit
EOF

/usr/local/myproj/bitcoinLab/master.sh << EOF
bandwidth
3
192.168.2.0/24
192.168.3.0/24
1024kbit
EOF