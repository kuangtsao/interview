ps -A | grep -w "YGAPI"| awk '{print $1}' | xargs kill -9

echo "YGAPI closed" 

sleep 2

ps -A | grep -w "YGAPI_H5_Log"| awk '{print $1}' | xargs kill -9

echo "YGAPI_H5_Log closed"

sleep 2

ps -A | grep -w "YGAPI_for_develop"| awk '{print $1}' | xargs kill -9

echo "YGAPI_for_develop closed"
