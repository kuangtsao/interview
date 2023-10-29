#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:$DIR
source DNS
port=443
now_date=$(date -u +"%Y-%m-%d")
now_seconds=$(date -u +"%s" --date "$now_date")
vaild_day=30

echo "URL" >> $DIR/url_not_exist_$now_date
echo "URL ssl_end_date remaining_days" >> $DIR/ssl_check_failed_$now_date
echo "URL remaining_days" >> $DIR/ssl_check_lessthan0_$now_date

for host in "${DNS[@]}"
do
  exist=$(curl --silent --head --connect-timeout 5 "https://$host")
  if [ -n "$exist" ] 
  then
    echo "URL $host exists"
    end_date=$(openssl s_client -servername $host -host $host -port $port -prexit </dev/null 2>/dev/null |
              sed -n '/BEGIN CERTIFICATE/,/END CERT/p' |
              openssl x509 -text 2>/dev/null |
              sed -n 's/ *Not After : *//p')
    echo "$host $end_date"
    end_date_seconds=$(date -u +"%s" --date "$end_date")
    end_date_format=$(date -u +"%Y-%m-%d" --date "$end_date")    
    until_days=$(bc <<< "($end_date_seconds-$now_seconds)/86400")
    echo "剩下 $until_days 天"
    if [ "$until_days" -le "0" ]
    then
      echo "網址 https://$host 的 SSL 天數為負數天: $until_days"
      echo "https://$host $until_days" >> $DIR/ssl_check_lessthan0_$now_date
    fi  
    if [ "$until_days" -gt "0" ] && [ "$until_days" -lt "$vaild_day" ]
    then    
      curl -s -X POST "https://api.telegram.org/bot1360304208:AAGn2JhnaG6qFpbKt4wlcEwEbUUmOG_jClM/sendMessage" -d chat_id="-408852309" -d text="網址 https://$host 的 SSL 終止日期為 $end_date_format，剩下 $until_days 天，有效期限已小於 $vaild_day 天，請安排更換"
      echo "https://$host $end_date_format $until_days $vaild_day" >> $DIR/ssl_check_failed_$now_date
      #echo "網址 $host 的 SSL 終止日期為 $end_date_format，剩下 $until_days 天，有效期限已小於 $vaild_day 天，請安排更換"
    fi                   
  else
    echo "$host" >> $DIR/url_not_exist_$now_date
    echo "URL $host doesn't exists or wrong configuration on nginx"
  fi
done

SSL_CHECK_LT_0_COUNTER=$(wc -l $DIR/ssl_check_lessthan0_$now_date | awk {'print $1'})
SSL_CHECK_FAILED_COUNTER=$(wc -l $DIR/ssl_check_failed_$now_date | awk {'print $1'})
URL_NOT_EXIST_COUNTER=$(wc -l $DIR/url_not_exist_$now_date | awk {'print $1'})

if [ -e "$DIR/ssl_check_lessthan0_$now_date" ] && [ "$SSL_CHECK_LT_0_COUNTER" -gt "1" ]
then
  curl -F document=@"$DIR/ssl_check_lessthan0_$now_date" https://api.telegram.org/bot1360304208:AAGn2JhnaG6qFpbKt4wlcEwEbUUmOG_jClM/sendDocument?chat_id="-408852309"
fi

if [ -e "$DIR/ssl_check_failed_$now_date" ] && [ "$SSL_CHECK_FAILED_COUNTER" -gt "1" ]
then
  curl -F document=@"$DIR/ssl_check_failed_$now_date" https://api.telegram.org/bot1360304208:AAGn2JhnaG6qFpbKt4wlcEwEbUUmOG_jClM/sendDocument?chat_id="-408852309"
fi

if [ -e "$DIR/url_not_exist_$now_date" ] && [ "$URL_NOT_EXIST_COUNTER" -gt "1" ]
then
  curl -F document=@"$DIR/url_not_exist_$now_date" https://api.telegram.org/bot1360304208:AAGn2JhnaG6qFpbKt4wlcEwEbUUmOG_jClM/sendDocument?chat_id="-408852309"
fi