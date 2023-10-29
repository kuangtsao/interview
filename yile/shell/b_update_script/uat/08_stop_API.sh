#!/bin/bash
ps -A | grep -w "YGAPI"| awk '{print $1}' | xargs kill -9

echo "YGAPI closed" 

sleep 2

ps -A | grep -w "YGAPI_for_develop"| awk '{print $1}' | xargs kill -9 
ps -A | grep -w "YGAPI_for_devel"| awk '{print $1}' | xargs kill -9 #有時會找不到YGAPI_for_develop，所以需要用這兩個方式搜尋

echo "YGAPI_for_develop closed"

sleep 2

ps -A | grep -w "YGAPI_H5_Log"| awk '{print $1}' | xargs kill -9

echo "YGAPI_H5_Log closed"

