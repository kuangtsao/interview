#!/bin/bash

#./update_games.sh enviorment option

set -x

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
  ZIP_FILE_PATH="/data/svn/yg001/code/game/uat-$VERSION.zip"
  UPDATE_GAMES="/data/YG/04_UAT_update_game_bylist.sh"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/UAT_all_games.txt"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  SVN_GAMES_LIST="/data/svn/yg001/conf/list/UAT_games.txt"
  GAMES_LIST="/data/YG/games.txt"
  CHECK_GAME_LIST_NOTEMPTY="/data/YG/check_game_list_empty.sh"
  CHECK_GANE_LIST_INLIST="/data/YG/compare.py"
  CHECK_GANE_LIST_REPEAT="/data/YG/repeat.py"  
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  #ALL_GAMES_LIST="./b_jenkins/configs/demo/all_games.txt"
  #GAMES_LIST="./b_jenkins/configs/demo/games.txt"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/demo-$VERSION.zip"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/DEMO_all_games.txt"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  SVN_GAMES_LIST="/data/svn/yg001/conf/list/DEMO_games.txt"
  GAMES_LIST="/data/YG/games.txt"
  UPDATE_GAMES="/data/YG/04_DEMO_update_game_bylist.sh"
  CHECK_GAME_LIST_NOTEMPTY="/data/YG/check_game_list_empty.sh"
  CHECK_GANE_LIST_INLIST="/data/YG/compare.py"
  CHECK_GANE_LIST_REPEAT="/data/YG/repeat.py"
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  #ALL_GAMES_LIST="./b_jenkins/configs/prd/all_games.txt"
  #GAMES_LIST="./b_jenkins/configs/prd/games.txt"
  ZIP_FILE_PATH="/data/svn/yg001/code/game/prd-$VERSION.zip"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/PRD_all_games.txt"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  SVN_GAMES_LIST="/data/svn/yg001/conf/list/PRD_games.txt"
  GAMES_LIST="/data/YG/games.txt"
  UPDATE_GAMES="/data/YG/04_Prd_update_game_bylist.sh"
  CHECK_GAME_LIST_NOTEMPTY="/data/YG/check_game_list_empty.sh"
  CHECK_GANE_LIST_INLIST="/data/YG/compare.py"
  CHECK_GANE_LIST_REPEAT="/data/YG/repeat.py" 
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：開始更新 $ENVIORMENT 環境遊戲 $VERSION 版"

CHECK=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST ls $ZIP_FILE_PATH )

if [ $? != 0 ]; then
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：欲上傳的版本不存在，請檢查$BUILD_URL"
  exit 0
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME；開始更新 YG 指定遊戲"
fi


echo "Step 1: 上傳最新遊戲名單"
DEPLOY_ALL_GAMES_LIST="cp $SVN_ALL_GAMES_LIST $ALL_GAMES_LIST"
DEPLOY_GAMES_LIST="cp $SVN_GAMES_LIST $GAMES_LIST"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_ALL_GAMES_LIST
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_GAMES_LIST

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境遊戲名單更新完畢"

echo "Step 2: 檢查遊戲名單"

flag_notempty=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GAME_LIST_NOTEMPTY)

if [[ $flag_notempty == "True" ]]; then
   echo " games.txt 檢查不為空與檔案末端有空行，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 為空檔案或者檔案末端沒有空行，更新程式中止。"
   exit 0
fi

flag_inlist=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GANE_LIST_INLIST)

if [[ $flag_inlist == "True" ]]; then
   echo "games.txt 內名單均有在 all_games.txt 裡，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 有錯誤，錯誤內容為 $flag_inlist，煩請檢查。更新程式中止"
   exit 0
fi

flag_repeat=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GANE_LIST_REPEAT)

if [[ $flag_repeat == "True" ]]; then
   echo "games.txt 內名單無重複填入遊戲名稱，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 有錯誤，錯誤內容為 $flag_repeat，煩請檢查。更新程式中止"
   exit 0
fi

echo "Step 3: 解壓縮 /data/svn 下的更新檔案"

UNZIP_TMP_ZIP="unzip -o $ZIP_FILE_PATH -d /tmp"

ssh -i $IDENTITY_FILE_PATH $USER@$HOST $UNZIP_TMP_ZIP
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 SVN 檔案取得完畢"

echo "Step 4: 更新遊戲"
ssh -i $IDENTITY_FILE_PATH $USER@$HOST $UPDATE_GAMES

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境遊戲更新完畢"

#echo "刪除 /tmp 裡的遊戲"
#ssh -i $IDENTITY_FILE_PATH $USER@$HOST $REMOVE_TMP_GAMES
