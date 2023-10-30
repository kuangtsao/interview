#!/bin/bash

# shell 的 debug 選項，方便看餵入的參數用
set -x

# jenkins 會提供後面的參數給 shell
# 指定環境
ENVIORMENT=$1
BOT=$2
SVN_PATH="/data/svn/yg001"

if [ $BOT == 1 ]; then
  BOT_TOKEN="https://api.telegram.org/botbot_token/sendMessage"
  CHAT_ID="chatroom"
else
  echo "BOT 填錯了，目前為：$BOT"
  exit 0
fi

# 根據環境去切變數，HOSTS 記需要主機資訊
if [ $ENVIORMENT == "UAT" ]; then
  echo "in UAT"
  USER=centos
  HOSTS=(
    "yg-t-game01|some.remote.public.ip|/mnt/yile/ssh_key/B/UAT_key.pem"
    "yg-t-java01|[host ip]|/mnt/yile/ssh_key/B/yg-t-java01.pem"
    "yg-t-proxyweb01|[host ip]|/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  )
  
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOSTS=(
    "yg-demo|some.remote.public.ip|/mnt/yile/ssh_key/B/Demo_key.pem"
    "yg-t-proxyweb01|[host ip]|/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  )
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOSTS=(
    "YG_prd_webproxy|[host ip]|/mnt/yile/ssh_key/B/prd-yg-proxy.pem" 
    "YG_prd_bs|[host ip]|/mnt/yile/ssh_key/B/prd-yg-bs.pem" 
    "yg-prd-central-gs|some.remote.public.ip|/mnt/yile/ssh_key/B/prd-yg-central-GS"
    "yg-prd-auth|[host ip]|/mnt/yile/ssh_key/B/prd-yg-auth.pem"
  )
else
  echo "環境變數不正確"
  #curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：環境變數不正確，請檢查$BUILD_URL"
  exit 0
fi

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 $SVN_PATH 更新開始"

echo "STEP 1: 更新 SVN"

for pair in ${HOSTS[@]};
do
  IFS=$'|' read -r name host key <<< "$pair"
  echo "$name $SVN_PATH 開始更新"
  echo "ssh -i $key $USER@$host svn update $SVN_PATH"
  echo "$name $SVN_PATH 更新完畢"
done

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 $SVN_PATH 更新完畢"
