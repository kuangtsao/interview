#!/bin/bash -x

CURRENT=`pwd`


cd $CURRENT/YGAPI/release
nohup ./YGAPI &

sleep 2

cd $CURRENT/YGAPI_for_develop/release
nohup ./YGAPI_for_develop &

sleep 2

cd $CURRENT/YGAPI_H5_Log/release
nohup ./YGAPI_H5_Log &

sleep 2

cd  $CURRENT/YGAPI_Alert/release
nohup ./YGAPI_Alert &

