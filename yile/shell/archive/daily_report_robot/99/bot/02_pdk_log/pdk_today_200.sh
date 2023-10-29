#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M'`
DATE1=`date '+%Y-%m-%d'`
DATE2=`date --date='0 days ago' "+%Y_%m_%d"`

logpatch="/data/game_zip_log/zoo/02_pdk/$DATE2/ZOO_LOG"

atotal=0
for((i=0; i<=23; i++))
do
        x=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" | awk 'BEGIN {FS="玩了"} NR=='$i'+9 {print ($2)-0}')
        atotal=$(($atotal+$x))
done

apk=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩家PK="}; NR==4{print ($2)-0}')
awii=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="機器人勝場="}; NR==5{print ($2)-0}')
awii1=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="機器人勝率="}; NR==6{print ($2)-0}')
asyswii=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="系統總勝負="}; NR==7{print ($2)-0}')
asystowii=$(cat "$logpatch/PDK_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩家總贏="}; NR==8{print ($2)-0}')

TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE1=$(echo -e "$DATE
久久跑得快2底分場
玩家總贏: $asystowii 元
局數: $atotal
PK: $apk
勝場:$awii
勝率:$awii1
輸贏:$asyswii
")

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

#echo -e "$asyswii"
