#!/bin/sh

echo "start update game Lobby"


if [ -z "$1" ]
then
   echo "沒設定參數,預設值 games.txt";
   filename="/data/YG/games.txt"
else
   filename="/data/YG/all_games.txt"
fi

echo $filename

if [[ -s "$filename" && -z "$(tail -c 1 "$filename")" ]]
then
    echo "$filename 檢查正常，繼續執行更新程式。"
else
    echo "$filename 為空檔案或者檔案末端沒有空行，更新程式中止。"
    exit 0
fi

for game in $(cat $filename)
do
  /data/YG/YGGames/$game/update_lobby.sh
done

echo "game Lobby updated"

rm -f /tmp/YGDNLobby
echo "/tmp/YGDNLobby 清理完畢"

file1=/tmp/YGLobby

[ ! -f $file1 ] && { echo "$file1 not exit";exit; }

cp /data/YG/YGLobby/release/YGLobby /data/YG/YGLobby/backup/YGLobby_$now
cp $file1 /data/YG/YGLobby/release/YGLobby

echo "YGLobby updated"

rm -f /tmp/YGLobby

echo "/tmp/YGLobby 清理完畢"
