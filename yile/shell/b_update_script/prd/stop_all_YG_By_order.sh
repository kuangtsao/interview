#!/bin/bash -x

./stop_game_bylist.sh all_games.txt

sleep 1
ps -A | grep "YGLobby"| awk '{print $1}' | xargs kill -9

echo "YGLobby closed" 

# 關閉 Center
sleep 30
ps -A | grep "YGCentral" | awk '{print $1}' | xargs kill -9

echo "YGCentral closed"
sleep 1
# 關閉 DBA
ps -A | grep "YGDBA"| awk '{print $1}' | xargs kill -9

echo "YGDBA closed"
sleep 1

# 結束所有 YG 程序
ps -A | grep "YG" | awk '{print $1}' | xargs kill -9

echo "YGRedis and others closed"
