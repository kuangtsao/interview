#!/bin/bash

DATE=`date '+%Y-%m-%d %H:%M'`
DATE1=`date '+%Y-%m-%d'`
DATE2=`date --date='0 days ago' "+%Y_%m_%d"`

logpatch="/home/qpdevops/bash/bot/sql"

water=$(cat "$logpatch/test.txt" |grep -v 'water' | head -n 1)
totalDeposit=$(sed -n '4,4p' "$logpatch/test.txt" )

TOKEN='telegram bot token'
CHAT_ID='-384648296'

URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE1=$(echo -e "$DATE
歡樂
流水: $water
總存款:$totalDeposit
")

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE1"

#echo -e "$asyswii"
