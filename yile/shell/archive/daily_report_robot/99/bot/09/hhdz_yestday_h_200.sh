#!/bin/bash

DATE=`date --date='1 days ago' "+%Y-%m-%d"`
DATE2=`date --date='1 days ago' "+%Y_%m_%d"`
logpatch="/data/game_zip_log/zoo/01_ddz/$DATE2/ZOO_LOG"
logpatch2="/home/qwer99/bash/bot/01_ddz_log"

TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

session=() #場次
list=() #每小時進行總局數

for((i=0; i<=23; i++))
do
        session[${#session[*]}]=$(cat "$logpatch/DDZ_Statistics_Room_200.log.txt" | awk 'BEGIN {FS="玩了"} NR=='$i'+9 {print ($2)-0}')
        printf "%02d %s % 3d %s\n" $i 時 ${session[$i]} 場 >> "$logpatch2/DDZ_200.txt"
done

MESSAGE1=$(echo -e "$DATE
久久鬥地主2底分場"
cat $logpatch2/DDZ_200.txt)

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

rm -rf "$logpatch2/DDZ_200.txt"
