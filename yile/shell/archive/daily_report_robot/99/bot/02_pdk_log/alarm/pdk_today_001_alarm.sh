#!/bin/bash -x

DATE=`date '+%Y-%m-%d %H:%M'`
DATE1=`date '+%Y-%m-%d'`
DATE2=`date --date='0 days ago' "+%Y_%m_%d"`

logpatch="/data/game_zip_log/zoo/02_pdk/$DATE2/ZOO_LOG"


a00=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==9{print ($2)-0}')
a01=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==10{print ($2)-0}')
a02=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==11{print ($2)-0}')
a03=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==12{print ($2)-0}')
a04=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==13{print ($2)-0}')
a05=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==14{print ($2)-0}')
a06=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==15{print ($2)-0}')
a07=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==16{print ($2)-0}')
a08=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==17{print ($2)-0}')
a09=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==18{print ($2)-0}')
a10=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==19{print ($2)-0}')
a11=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==20{print ($2)-0}')
a12=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==21{print ($2)-0}')
a13=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==22{print ($2)-0}')
a14=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==23{print ($2)-0}')
a15=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==24{print ($2)-0}')
a16=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==25{print ($2)-0}')
a17=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==26{print ($2)-0}')
a18=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==27{print ($2)-0}')
a19=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==28{print ($2)-0}')
a20=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==29{print ($2)-0}')
a21=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==30{print ($2)-0}')
a22=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==31{print ($2)-0}')
a23=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩了"}; NR==32{print ($2)-0}')
atoall=$((a00+a01+a02+a03+a04+a05+a06+a07+a08+a09+a10+a11+a12+a13+a14+a15+a16+a17+a18+a19+a20+a21+a22+a23))

apk=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩家PK="}; NR==4{print ($2)-0}')
awii=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="機器人勝場="}; NR==5{print ($2)-0}')
awii1=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="機器人勝率="}; NR==6{print ($2)-0}')
asyswii=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="系統總勝負="}; NR==7{print ($2)-0}')
asystowii=$(cat "$logpatch/PDK_Statistics_Room_001.log.txt" |awk 'BEGIN {FS="玩家總贏="}; NR==8{print ($2)-0}')

TOKEN='telegram bot token'
CHAT_ID='-432023024'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE1=$(echo -e "$DATE
要注意了
久久跑得快0.1底分場
玩家總贏: $asystowii 元
局數: $atoall
PK: $apk
勝場:$awii
勝率:$awii1
輸贏:$asyswii
")

MESSAGE2=$(echo -e "$DATE
通知PM關機器人
久久跑得快0.1底分場
玩家總贏: $asystowii 元
局數: $atoall
PK: $apk
勝場:$awii
勝率:$awii1
輸贏:$asyswii
")


if  [ $asystowii -le -2500 ]  
then  

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE2"
 
elif [ $asystowii -le -1000 ]
then  

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

else 
 
echo "ok"  
fi



#curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"




#    curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"





#    curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"
    


#curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"






#echo -e "$asyswii"
