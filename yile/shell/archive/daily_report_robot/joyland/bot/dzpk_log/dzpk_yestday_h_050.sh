#!/bin/bash

DATE=`date --date='1 days ago' "+%Y-%m-%d"`
DATE2=`date --date='1 days ago' "+%Y_%m_%d"`
logpatch="/data/game_zip_log/zoo/04_dzpk/$DATE2/ZOO_LOG"
logpatch2="/home/qpdevops/bash/bot/dzpk_log"


TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

session=() #場次
list=() #每小時進行總局數

for((i=0; i<=23; i++))
do
        session[${#session[*]}]=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" | awk 'BEGIN {FS="玩了"} NR=='$i'+9 {print ($2)-0}')
        printf "%02d %s % 3d %s\n" $i 時 ${session[$i]} 場 >> "$logpatch2/DZPK_050.txt"
done

MESSAGE1=$(echo -e "$DATE
歡樂德州撲克50底分場"
cat $logpatch2/DZPK_050.txt)

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

rm -rf "$logpatch2/DZPK_050.txt"
