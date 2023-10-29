#!/bin/bash

# shell 的 debug 選項，方便看餵入的參數用
set -x

# jenkins 會提供後面的參數給 shell
# 指定環境
ENVIORMENT=$1
# 指定版本
VERSION=$2
# 指定 BOT
BOT=$3
#利用參數組合，找出 filename
FILE_NAME="web-mobile-YGGame-$ENVIORMENT-$VERSION.zip"

# 依據填入的 BOT 參數切換
if [ $BOT == 1 ]; then
  BOT_TOKEN="https://api.telegram.org/bot1864086086:AAGu2_VFuSlDcLHYLWu3rDdjVNfjpGW3T9U/sendMessage"
  CHAT_ID="-443492941"
else
  echo "BOT 填錯了，目前為：$BOT"
  exit 0
fi

# 如果有看到沒有在 shell 定義的全域變數，都在 jenkins 裡面，可登入查看 管理 jenkins -> 設定系統 -> 全域屬性 -> 環境變數
#這邊基本上寫的是環境變數，便於抽換，基本上每一層的邏輯都一樣
if [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=$B_UAT_DEMO_H5_USER
  HOST=$B_UAT_DEMO_H5_HOST
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  # H5 檔案在遠端主機的位置
  UPDATE_FILE_PATH="/data/svn/yg001/html/web-mobile-$ENVIORMENT-$VERSION"
  # 準備丟進 h5 更新 shell 的參數
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

echo "step 1: 執行更新 shell"
EXECUTE_SHELL="/data/$DEPLOY_DIR/update.sh $VERSION $ENVIORMENT $DEPLOY_DIR"
echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $EXECUTE_SHELL"
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 H5 $VERSION 版更新完畢，請驗證版號。"
