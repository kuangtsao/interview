#!/bin/bash -x


if [ -z "$1" ]
then
   echo "沒設定參數,預設值 games.txt";
   filename="games.txt"
else
   filename=$1
fi

echo $filename

CURRENT=`pwd`
#filename='games.txt'
exec < $filename

while read line
do
    echo $line # 一行一行印出內容
    cd $CURRENT/YGGames/$line
    ./stop.sh
done

