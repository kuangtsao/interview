#!/bin/bash

#./update_api.sh enviorment version

ENVIORMENT=$1
VERSION=$2
BOT=$3

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
  EXECUTE_UPDATE_API="cd /data/YG && /data/YG/06_UAT_update_API.sh"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/uat-$VERSION.zip"
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  EXECUTE_UPDATE_API="cd /data/YG && /data/YG/06_DEMO_update_API.sh"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/demo-$VERSION.zip"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  EXECUTE_UPDATE_API="cd /data/YG && /data/YG/06_Prd_update_API.sh"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/prd-$VERSION.zip"
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

CHECK=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST ls $ZIP_FILE_PATH )

if [ $? != 0 ]; then
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：欲上傳的版本不存在，請檢查$BUILD_URL"
  exit 0
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新 YG api"
fi


echo "Step 1: 解壓縮 /data/svn 下的更新檔案"

UNZIP_TMP_ZIP="unzip -o $ZIP_FILE_PATH -d /tmp"

ssh -i $IDENTITY_FILE_PATH $USER@$HOST $UNZIP_TMP_ZIP
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 SVN 檔案取得完畢"

echo "Step 2:執行更新 API "
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新 $ENVIORMENT 環境 API $VERSION 版"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $EXECUTE_UPDATE_API
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 API 更新結束"

echo "刪除 /tmp/YGAPI*"
REMOVE_TMP_API="rm -f /tmp/YGAPI"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $REMOVE_TMP_API
