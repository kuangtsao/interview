#!/bin/bash

#./update_games_lobby.sh enviorment version

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
  REMOVE_TMP_GAMES="rm -f /tmp/$(cat ./b_jenkins/configs/uat/all_games.txt)"
  ALL_GAMES_LIST="./b_jenkins/configs/uat/all_games.txt"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/uat-$VERSION.zip"
  UPDATE_GAME_LOBBY="/data/YG/05_UAT_update_lobby_bylist.sh all_games.txt"
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  REMOVE_TMP_GAMES="rm -f /tmp/$(cat ./b_jenkins/configs/demo/all_games.txt)"
  ALL_GAMES_LIST="./b_jenkins/configs/demo/all_games.txt"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/demo-$VERSION.zip"
  UPDATE_GAME_LOBBY="/data/YG/05_DEMO_update_lobby_bylist.sh all_games.txt"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  REMOVE_TMP_GAMES="rm -f /tmp/$(cat ./b_jenkins/configs/prd/all_games.txt)"
  ALL_GAMES_LIST="./b_jenkins/configs/prd/all_games.txt"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/prd-$VERSION.zip"
  UPDATE_GAME_LOBBY="/data/YG/05_Prd_update_lobby_bylist.sh all_games.txt"
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

CHECK=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST ls $ZIP_FILE_PATH )

if [ $? != 0 ]; then
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：欲上傳的版本不存在，請檢查$BUILD_URL"
  exit 0
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME；開始更新 YG 所有遊戲大廳 $VERSION 版"
fi


echo "執行更新遊戲大廳"

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新 $ENVIORMENT 環境遊戲大廳"


echo "Step 1:更新 all_games.txt"
scp -i $IDENTITY_FILE_PATH $ALL_GAMES_LIST $USER@$HOST:/data/YG

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境所有遊戲名單更新完畢"

echo "Step 2: 解壓縮 /data/svn 下的更新檔案"

UNZIP_TMP_ZIP="unzip -o $ZIP_FILE_PATH -d /tmp"

ssh -i $IDENTITY_FILE_PATH $USER@$HOST $UNZIP_TMP_ZIP
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 SVN 檔案取得完畢"


echo "Step 3: 更新遊戲大廳"

ssh -i $IDENTITY_FILE_PATH $USER@$HOST $UPDATE_GAME_LOBBY

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境遊戲更新完畢"

#ssh -i $IDENTITY_FILE_PATH $USER@$HOST $REMOVE_TMP_GAMES
