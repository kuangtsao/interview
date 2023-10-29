#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M'`
DATE1=`date '+%Y-%m-%d'`
DATE2=`date --date='0 days ago' "+%Y_%m_%d"`

logpatch="/data/game_zip_log/zoo/04_dzpk/$DATE2/ZOO_LOG"

atotal=0
for((i=0; i<=23; i++))
do
        x=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" | awk 'BEGIN {FS="玩了"} NR=='$i'+9 {print ($2)-0}')
        atotal=$(($atotal+$x))
done

apk=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" |awk 'BEGIN {FS="玩家PK="}; NR==4{print ($2)-0}')
awii=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" |awk 'BEGIN {FS="機器人勝場="}; NR==5{print ($2)-0}')
awii1=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" |awk 'BEGIN {FS="機器人勝率="}; NR==6{print ($2)-0}')
asyswii=$(cat "$logpatch/DZPK_Statistics_Room_050.log.txt" |awk 'BEGIN {FS="系統總勝負="}; NR==7{print ($2)-0}')

TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE1=$(echo -e "$DATE
久久德州撲克50底分場
局數: $atotal
PK: $apk
勝場:$awii
勝率:$awii1
輸贏:$asyswii
")

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

#echo -e "$asyswii"
