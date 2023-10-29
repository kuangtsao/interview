#!/bin/bash -x

CURRENT=`pwd`

cd $CURRENT/YGDBA
cd central_use
nohup ./run_YGDBA_central.sh &

cd ../central_use1
nohup ./run_YGDBA_central1.sh &

cd ../central_use2
nohup ./run_YGDBA_central2.sh &

cd ../central_use3
nohup ./run_YGDBA_central3.sh &

cd ../central_use4
nohup ./run_YGDBA_central4.sh &

cd ../quest_use
nohup ./run_YGDBA_quest.sh &

cd ../dn_use
nohup ./run_YGDBA_dn.sh &

cd ../api_use
nohup ./run_YGDBA_api.sh &

cd ../../YGRedis/release
nohup ./run_YGRedis.sh &

sleep 2

cd $CURRENT/YGCentral/release
nohup ./YGCentral &

sleep 2

cd $CURRENT/YGLobby/release
nohup ./YGLobby &

sleep 2

cd $CURRENT/YGAPI/release
nohup ./YGAPI &

sleep 2

cd $CURRENT/YGAPI_H5_Log/release
nohup ./YGAPI_H5_Log &

sleep 2

cd $CURRENT/YGAPI_for_develop/release
nohup ./YGAPI_for_develop &

