#!/bin/sh

echo "start update games"


if [ -z "$1" ]
then
   echo "沒設定參數,預設值 games.txt";
   filename="/data/YG/games.txt"
else
   filename="/data/YG/all_games.txt"
fi

echo $filename

for game in $(cat $filename)
do
  /data/YG/YGGames/$game/update.sh
  rm -f /tmp/$game
  echo "/tmp/$game 刪除完畢"
done

echo "end update games"
