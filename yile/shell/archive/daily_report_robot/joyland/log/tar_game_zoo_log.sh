#!/bin/bash

##yesterday
ydays=`date --date='1 days ago' "+%Y_%m_%d"`
ydaysa=`date --date='1 days ago' "+%Y%m%d"`


log_patch01=/data/deploy/01_douDiZhu/ZOO_LOG
glog_patch01=/data/game_zip_log/zoo

##yesterday
tar -zcvf $glog_patch01/01_ddz/jl_ddz_"$ydaysa".tar.gz -C $log_patch01 $ydays

