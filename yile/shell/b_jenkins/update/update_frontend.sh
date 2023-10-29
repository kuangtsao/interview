#!/bin/bash

set -x
DATE=$(date +"%F_%T")
ENVIORMENT=$1
VERSION=$2
BOT=$3
FILE_NAME="web-mobile-YGGame-$ENVIORMENT-$VERSION.zip"

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

# 如果有看到沒有在 shell 定義的全域變數，都在 jenkins 裡面，可登入查看 管理 jenkins -> 設定系統 -> 全域屬性 -> 環境變數

if [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=$B_UAT_DEMO_H5_USER
  HOST=$B_UAT_DEMO_H5_HOST
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  UPDATE_FILE_PATH="/data/svn/yg001/html/web-mobile-$ENVIORMENT-$VERSION"
  DEPLOY_PATH="/data/web-mobile_1"
  DEPLOY_DIR="web-mobile_1"
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=$B_UAT_DEMO_H5_USER
  HOST=$B_UAT_DEMO_H5_HOST
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  UPDATE_FILE_PATH="/data/svn/yg001/html/web-mobile-$ENVIORMENT-$VERSION"
  DEPLOY_PATH="/data/web-demo"
  DEPLOY_DIR="web-demo"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=$B_PRD_H5_USER
  HOST=$B_PRD_H5_HOST
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-proxy.pem"
  UPDATE_FILE_PATH="/data/svn/yg001/html/web-mobile-$ENVIORMENT-$VERSION"
  DEPLOY_PATH="/data/web_ygh5"
  DEPLOY_DIR="web_ygh5"
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi


CHECK=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST ls $UPDATE_FILE_PATH )

if [ $? != 0 ]; then
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：欲上傳的版本不存在，請檢查$BUILD_URL"
  exit 0
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新 $ENVIORMENT 環境 H5 $VERSION 版"
fi

#for filename in $CHECK;
#do
#  if [ $filename != web-mobile-$ENVIORMENT* ]; then
#    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$filename 不符合命名規則，更新流程中止，請通知開發重新上傳檔案"
#    exit 0
#  fi
#done


echo "step 1: 執行更新 shell"
EXECUTE_SHELL="/data/$DEPLOY_DIR/update.sh $VERSION $ENVIORMENT $DEPLOY_DIR"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $EXECUTE_SHELL
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 H5 $VERSION 版更新完畢，請驗證版號。"
