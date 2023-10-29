#!/bin/bash

set -x

ENVIORMENT=$1
BOT=$2
SVN_PATH="/data/svn/yg001"

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
  HOSTS=(
    "yg-t-game01|some.remote.public.ip|/mnt/yile/ssh_key/B/UAT_key.pem"
    "yg-t-java01|54.179.73.50|/mnt/yile/ssh_key/B/yg-t-java01.pem"
    "yg-t-proxyweb01|52.76.174.81|/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  )
  
elif [ $ENVIORMENT == "DEMO" ]; then
  echo "in DEMO"
  USER=centos
  HOSTS=(
    "yg-demo|some.remote.public.ip|/mnt/yile/ssh_key/B/Demo_key.pem"
    "yg-t-proxyweb01|52.76.174.81|/mnt/yile/ssh_key/B/yg-t-proxyweb01.pem"
  )
elif [ $ENVIORMENT == "PRD" ]; then
  echo "in PRD"
  USER=centos
  HOSTS=(
    "YG_prd_webproxy|18.136.130.196|/mnt/yile/ssh_key/B/prd-yg-proxy.pem" 
    "YG_prd_bs|13.212.122.25|/mnt/yile/ssh_key/B/prd-yg-bs.pem" 
    "yg-prd-central-gs|some.remote.public.ip|/mnt/yile/ssh_key/B/prd-yg-central-GS"
    "yg-prd-auth|18.140.235.153|/mnt/yile/ssh_key/B/prd-yg-auth.pem"
  )
  IDENTITY_FILE_PATH="/mnt/yile/ssh_key/B/prd-yg-central-GS"
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
  ssh -i $key $USER@$host svn update $SVN_PATH
  echo "$name $SVN_PATH 更新完畢"
done

curl -s -X POST "$BOT_TOKEN" -d chat_id="$CHAT_ID" -d text="$JOB_NAME：$ENVIORMENT 環境 $SVN_PATH 更新完畢"
