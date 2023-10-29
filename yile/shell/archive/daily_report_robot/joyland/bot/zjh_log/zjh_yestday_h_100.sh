#!/bin/bash

DATE=`date --date='1 days ago' "+%Y-%m-%d"`
DATE2=`date --date='1 days ago' "+%Y_%m_%d"`
logpatch="/data/game_zip_log/zoo/03_zjh/$DATE2/ZOO_LOG"
logpatch2="/home/qpdevops/bash/bot/zjh_log"


TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

session=() #場次
list=() #每小時進行總局數

for((i=0; i<=23; i++))
do
        session[${#session[*]}]=$(cat "$logpatch/ZJH_Statistics_Room_100.log.txt" | awk 'BEGIN {FS="玩了"} NR=='$i'+9 {print ($2)-0}')
        printf "%02d %s % 3d %s\n" $i 時 ${session[$i]} 場 >> "$logpatch2/ZJH_100.txt"
done

MESSAGE1=$(echo -e "$DATE
歡樂炸金花5底分場"
cat $logpatch2/ZJH_100.txt)

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

rm -rf "$logpatch2/ZJH_100.txt"
