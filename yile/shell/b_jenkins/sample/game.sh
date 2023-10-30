#!/bin/bash

#game.sh enviorment option (all or partial)

# shell 的 debug 選項，方便看餵入的參數用
set -x
# jenkins 會提供後面的參數給 shell
# 指定環境
ENVIORMENT=$1
# 指定選項，更新全部遊戲或部分遊戲
OPTION=$2
# 指定 BOT
BOT=$3


# 依據填入的 BOT 參數切換
if [ $BOT == 1 ]; then
  BOT_TOKEN="https://api.telegram.org/botbot_token/sendMessage"
  CHAT_ID="chatroom"
else
  echo "BOT 填錯了，目前為：$BOT"
  exit 0
fi

#這邊基本上寫的是環境變數，便於抽換
if [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/UAT_key.pem"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  GAMES_LIST="/data/YG/games.txt"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/UAT_all_games.txt"
  SVN_GAMES_LIST="/data/svn/yg001/conf/list/UAT_games.txt"
  DEPLOY_ALL_GAMES_LIST="cp $SVN_ALL_GAMES_LIST $ALL_GAMES_LIST"
  DEPLOY_GAMES_LIST="cp $SVN_GAMES_LIST $GAMES_LIST"

  # 更新所有的 games.txt
  echo "更新 UAT games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_GAMES_LIST"
  echo "更新 UAT all_games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_ALL_GAMES_LIST"

  # 依據 jenkins 提供的選項，決定執行開啟全部遊戲還是部份遊戲
  if [ $OPTION == "all" ]; then
    GAMES="/data/YG/02_UAT_run_game_bylist.sh all_games.txt &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境所有遊戲"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
  elif [ $OPTION == "partial" ]; then
    GAMES="/data/YG/02_UAT_run_game_bylist.sh &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境以下遊戲："
    # 抓部分遊戲的更新名單
    GAMES_LIST_CONTENT=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST cat $SVN_GAMES_LIST)
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$GAMES_LIST_CONTENT"
  else
    echo "no other option"
    exit 0
  fi

# 其他的部分也會是同樣的邏輯
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/Demo_key.pem"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/DEMO_all_games.txt"
  DEPLOY_ALL_GAMES_LIST="cp $SVN_ALL_GAMES_LIST $ALL_GAMES_LIST"
  echo "更新 DEMO games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_GAMES_LIST"
  echo "更新 DEMO all_games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_ALL_GAMES_LIST"
  if [ $OPTION == "all" ]; then
    # 由於之前做實驗發現如果找原本的指令會 hang 住，故把輸出丟到 /dev/null
    GAMES="/data/YG/02_DEMO_run_game_bylist.sh all_games.txt &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境所有遊戲"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
  elif [ $OPTION == "partial" ]; then
    GAMES="/data/YG/02_DEMO_run_game_bylist.sh &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境以下遊戲："
    GAMES_LIST_CONTENT=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST cat $SVN_GAMES_LIST)
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$GAMES_LIST_CONTENT"
  else
    echo "no other option"
    exit 0
  fi
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOST=some.remote.public.ip
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
  GAMES_LIST="/data/YG/games.txt"
  ALL_GAMES_LIST="/data/YG/all_games.txt"
  SVN_ALL_GAMES_LIST="/data/svn/yg001/conf/list/PRD_all_games.txt"
  SVN_GAMES_LIST="/data/svn/yg001/conf/list/PRD_games.txt"
  DEPLOY_ALL_GAMES_LIST="cp $SVN_ALL_GAMES_LIST $ALL_GAMES_LIST"
  DEPLOY_GAMES_LIST="cp $SVN_GAMES_LIST $GAMES_LIST"
  echo "更新 PRD all_games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_ALL_GAMES_LIST"
  echo "更新 PRD games.txt"
  echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $DEPLOY_GAMES_LIST"
  if [ $OPTION == "all" ]; then
    GAMES="/data/YG/02_Prd_run_game_bylist.sh all_games.txt &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境所有遊戲"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
  elif [ $OPTION == "partial" ]; then
    GAMES="/data/YG/02_Prd_run_game_bylist.sh &> /dev/null"
    NOTIFY_MESSAGE="預計開啟 $ENVIORMENT 環境以下遊戲："
    GAMES_LIST_CONTENT=$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST cat $SVN_GAMES_LIST)
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$NOTIFY_MESSAGE"
    curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$GAMES_LIST_CONTENT"
  else
    echo "no other option"
    exit 0
  fi
else
  curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

echo "Step 1: 檢查遊戲名單"

CHECK_GAME_LIST_NOTEMPTY="/data/YG/check_game_list_empty.sh"
CHECK_GANE_LIST_INLIST="/data/YG/compare.py"
CHECK_GANE_LIST_REPEAT="/data/YG/repeat.py" 

flag_notempty=True
#$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GAME_LIST_NOTEMPTY)

if [[ $flag_notempty == "True" ]]; then
   echo " games.txt 檢查不為空與檔案末端有空行，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 為空檔案或者檔案末端沒有空行，更新程式中止。"
   exit 0
fi

flag_inlist=True
#$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GANE_LIST_INLIST)

if [[ $flag_inlist == "True" ]]; then
   echo "games.txt 內名單均有在 all_games.txt 裡，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 有錯誤，錯誤內容為 $flag_inlist，煩請檢查。更新程式中止"
   exit 0
fi

flag_repeat=True
#$(ssh -i $IDENTITY_FILE_PATH $USER@$HOST $CHECK_GANE_LIST_REPEAT)

if [[ $flag_repeat == "True" ]]; then
   echo "games.txt 內名單無重複填入遊戲名稱，繼續執行"
else
   curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：games.txt 有錯誤，錯誤內容為 $flag_repeat，煩請檢查。更新程式中止"
   exit 0
fi

echo "Step 2: 開啟 $ENVIORMENT 環境的所有 YG 遊戲"

echo "ssh -i $IDENTITY_FILE_PATH $USER@$HOST $GAMES"
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：已開啟 $ENVIORMENT 環境 YG gameserver 指定遊戲。"
curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：請開始驗證服務與遊戲是否正常或者更新到需要版本。"
