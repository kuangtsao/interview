#!/bin/bash

./update_binary.sh [enviorment] [version]
./update_java.sh [enviorment] [application] [version]
./update_frontend.sh [enviorment] [version]

都在 jenkins 裡面

binary

all

scp path \\172.17.1.11\ITShare\ForUpdate\YG\[enviorment]\[version]\YG* central-gs/tmp
cp YGXXX to specific path

api
game

Java
if $application 
scp \\172.17.1.11\ITShare\Release\YG_Backend\[enviorment]\[date]\DevelopBS\[version]\YGInternalGameBackend.tar java:/tmp
scp \\172.17.1.11\ITShare\Release\YG_Backend\[enviorment]\[date]\AgentBS\[version]\YGGameBackend.war java:/tmp
scp \\172.17.1.11\ITShare\Release\YG_Backend\[enviorment]\[date]\MiddlewareApi\[version]\YGMiddlewareApi.war java:/tmp
scp \\172.17.1.11\ITShare\Release\YG_GameResult\[enviorment]\[date]\[version]\YGGameResult.war java:/tmp
scp \\172.17.1.11\ITShare\Release\YG_ThirdPartyAPI\[enviorment]\[date]\[version]\YGThridpartyAPI.war java:/tmp
scp \\172.17.1.11\ITShare\Release\YG_AuthAPI\[enviorment]\[version]\AuthenticationApi.war java:/tmp
then do
ssh java -i key execute 關閉服務
ssh java -i key execute 更新流程
ssh java -i key execute 開啟服務

frontend
\\172.17.1.11\ClientRelease\Official\YGGame\[version]\[enviorment]\web-mobile-YGGame-[enviorment]-[version].zip
ssh frontend 更新流程