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
  STOP_ALL_YG="/data/YG/stop_all_YG_By_order.sh"
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  STOP_ALL_YG="/data/YG/stop_all_YG_By_order.sh"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  STOP_ALL_YG="/data/YG/stop_all_YG_By_order.sh"
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

echo "關閉 $ENVIORMENT 環境的所有 YG 服務"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $STOP_ALL_YG
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="已關閉 $ENVIORMENT 環境 所有Server/games"
