#!/bin/bash

#all_yg.sh enviorment

set -x

ENVIORMENT=$1
BOT=$2

if [ $BOT == 1 ]; then
  BOT_TOKEN="https://api.telegram.org/[telegram bot token]/sendMessage"
  CHAT_ID="[telegram chat id]"
elif [ $BOT == 2 ]; then
  BOT_TOKEN="https://api.telegram.org/[telegram bot token]/sendMessage"
  CHAT_ID="[telegram chat id]"
else
  echo "BOT 填錯了，目前為：$BOT"
  exit 0
fi

if [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/UAT_key.pem"
  INIT="cd /data/YG && sh /data/YG/01_UAT_run_init.sh &> /dev/null"
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  INIT="cd /data/YG && sh /data/YG/01_DEMO_run_init.sh &> /dev/null"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  INIT="cd /data/YG && sh /data/YG/01_Prd_run_init.sh &> /dev/null"
else
  echo "$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

echo "開啟 $ENVIORMENT 環境的所有 YG gameserver 服務，請接著繼續開啟遊戲"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $INIT
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開啟 $ENVIORMENT 環境的所有 YG gameserver 服務，請接著繼續開啟遊戲"
