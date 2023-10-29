#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M'`
DATE1=`date '+%Y-%m-%d'`
DATE2=`date --date='1 days ago' "+%Y_%m_%d"`
DATE3=`date --date='1 days ago' "+%Y-%m-%d"`

logpatch="/data/game_zip_log/zoo/05_dn/$DATE2/ZOO_LOG"


a00=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==9{print ($2)-0}')
a01=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==10{print ($2)-0}')
a02=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==11{print ($2)-0}')
a03=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==12{print ($2)-0}')
a04=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==13{print ($2)-0}')
a05=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==14{print ($2)-0}')
a06=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==15{print ($2)-0}')
a07=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==16{print ($2)-0}')
a08=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==17{print ($2)-0}')
a09=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==18{print ($2)-0}')
a10=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==19{print ($2)-0}')
a11=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==20{print ($2)-0}')
a12=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==21{print ($2)-0}')
a13=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==22{print ($2)-0}')
a14=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==23{print ($2)-0}')
a15=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==24{print ($2)-0}')
a16=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==25{print ($2)-0}')
a17=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==26{print ($2)-0}')
a18=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==27{print ($2)-0}')
a19=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==28{print ($2)-0}')
a20=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==29{print ($2)-0}')
a21=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==30{print ($2)-0}')
a22=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==31{print ($2)-0}')
a23=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩了"}; NR==32{print ($2)-0}')
atoall=$((a00+a01+a02+a03+a04+a05+a06+a07+a08+a09+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19+a20+a21+a22+a23))

apk=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="玩家PK="}; NR==4{print ($2)-0}')
awii=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="機器人勝場="}; NR==5{print ($2)-0}')
awii1=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="機器人勝率="}; NR==6{print ($2)-0}')
asyswii=$(cat "$logpatch/DN_Statistics_Room_200.log.txt" |awk 'BEGIN {FS="系統總勝負="}; NR==7{print ($2)-0}')

TOKEN='telegram bot token'
CHAT_ID='telegram chat id'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE1=$(echo -e "$DATE3
歡樂搶庄牛牛10底分場
00時 $a00 場
01時 $a01 場
02時 $a02 場
03時 $a03 場
04時 $a04 場
05時 $a05 場
06時 $a06 場
07時 $a07 場
08時 $a08 場
09時 $a09 場
10時 $a10 場
11時 $a11 場
12時 $a12 場
13時 $a13 場
14時 $a14 場
15時 $a15 場
16時 $a16 場
17時 $a17 場
18時 $a18 場
19時 $a19 場
20時 $a20 場
21時 $a21 場
22時 $a22 場
23時 $a23 場

")




curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"






#echo -e "$asyswii"
