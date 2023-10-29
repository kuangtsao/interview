#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:$DIR
source DOMAINS
now_seconds=$(date +"%s")
now_date=$(date +"%Y-%m-%d")
vaild_day=30

echo "domain ssl_end_date remaining_days" >> $DIR/domain_check_failed_$now_date

for domain in "${DOMAINS[@]}"
do
  end_date=$(whois $domain | grep 'Expiry Date' | awk '{print $4}')
  echo "$domain $end_date"
  end_date_seconds=$(date +"%s" --date "$end_date")
  end_date_format=$(date +"%Y-%m-%d" --date "$end_date")    
  until_days=$(bc <<< "($end_date_seconds-$now_seconds)/24/3600")
  echo "剩下 $until_days 天"
  if [ "$until_days" -le "$vaild_day" ]
  then    
    curl -s -X POST "https://api.telegram.org/bot1360304208:AAGn2JhnaG6qFpbKt4wlcEwEbUUmOG_jClM/sendMessage" -d chat_id="-408852309" -d text="網址 $domain 的 domain 有效日期為 $end_date_format，剩下 $until_days 天，有效期限已小於 $vaild_day 天，請安排續約"
    echo "$domain $end_date_format $until_days" >> $DIR/domain_check_failed_$now_date
    #echo "網址 $domain 的 domain 有效日期為 $end_date_format，剩下 $until_days 天，有效期限已小於 $vaild_day 天，請安排續約"
  fi                   
done