#!/bin/bash

#scp \\172.17.1.11\ITShare\Release\YG_Backend\[enviorment]\[date]\MiddlewareApi\[version]\YGMiddlewareApi.war java:/tmp

set -x

DATE=$(date +"%F_%T")
ENVIORMENT=$1
VERSION=$2
BOT=$3
UPDATE_FILE_PATH="/data/svn/yg001/code/backend/YGMiddlewareAPI/YGMiddlewareApi-$ENVIORMENT-$VERSION.war"

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

if [ $ENVIORMENT == "TEST" ]; then
  echo "in TEST"
  USER=ec2-user
  HOST=13.208.164.35
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/aws-osaka.pem"
  DEPLOY_PATH="/data/tomcat-middleware-api/webapps"
  UPDATE_FILE_PATH="/data/svn/yg001/code/backend/YGMiddlewareAPI/YGMiddlewareApi-$ENVIORMENT-$VERSION.war"
  BINARY_PATH="/data/tomcat-agent-backend/bin"
elif [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=centos
  HOST=54.179.73.50
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/yg-t-java01.pem"
  DEPLOY_PATH="/data/tomcat-middleware-api/webapps"
  BINARY_PATH="/data/tomcat-middleware-api/bin"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=13.212.122.25
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-bs.pem"
  DEPLOY_PATH="/data/middleware-api/middleware-api-tomcat/webapps"
  BINARY_PATH="/data/middleware-api/middleware-api-tomcat/bin"
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

CHECK=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST ls $UPDATE_FILE_PATH )

if [ $? != 0 ]; then
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：欲上傳的版本不存在，請檢查$BUILD_URL"
  exit 0
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新middleware api"
fi

echo "Step 1: 上傳需更新版本"
CP_FILE="cp -a $UPDATE_FILE_PATH /tmp/YGMiddlewareApi.war"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CP_FILE 
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$FILE_NAME 已上傳到 $ENVIORMENT 環境。"

echo "Step 2: 關閉 $ENVIORMENT 環境的 middleware api"
SHUTDOWN_TOMCAT="$BINARY_PATH/catalina.sh stop"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $SHUTDOWN_TOMCAT 
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="已關閉 $ENVIORMENT middleware api $VERSION 版"

echo "Step 3: 備份舊檔案"
BACKUP_PREVIOUS_VERSION="cp $DEPLOY_PATH/YGMiddlewareApi.war /data/backup/YGMiddlewareApi.war_$DATE"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $BACKUP_PREVIOUS_VERSION 
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：舊檔案已備份為 /data/backup/YGMiddlewareApi.war_$DATE"

echo "Step 4: 部署 $ENVIORMENT middlewareapi $VERSION"
REMOVE_OLD_VERSION="rm -rf $DEPLOY_PATH/YGMiddlewareApi*"
COPY_UPLOAD_FILE="cp /tmp/YGMiddlewareApi.war $DEPLOY_PATH"
DEPLOY_NEW_VERSION="mkdir $DEPLOY_PATH/YGMiddlewareApi && cd $DEPLOY_PATH/YGMiddlewareApi &&jar -xvf $DEPLOY_PATH/YGMiddlewareApi.war"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $REMOVE_OLD_VERSION
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $COPY_UPLOAD_FILE
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_NEW_VERSION
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$FILE_NAME 已部署完畢。"

echo "Step 5: 開啟 $ENVIORMENT 環境的 middleware api"
SHUTDOWN_TOMCAT="$BINARY_PATH/catalina.sh start"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $SHUTDOWN_TOMCAT
echo "已開啟 $ENVIORMENT middleware api"
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="已開啟 $ENVIORMENT 環境 middleware api"

echo "Step 6: 清理 /tmp"
REMOVE_TMP_JAR="rm -f /tmp/YGMiddlewareApi.war"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $REMOVE_TMP_JAR 

