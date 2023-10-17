#!/bin/bash
while :
do
LANG=en
logfile=/tmp/`date +%d`.log
exec >> $logfile
date +"%F %H:%M"
sar -n DEV 1 59|grep Average|grep ens33|awk '{print $2,"\t","input:","\t",$5*1000*8,"bps","\n",$2,"\t","output:","\t",$6*1000*8,"bps"}'
echo "####################"
done
