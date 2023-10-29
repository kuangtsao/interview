#!/bin/bash


##today
days=`date --date='0 days ago' "+%Y_%m_%d"`
daysa=`date --date='0 days ago' "+%Y%m%d"`

##log patch
log_patch01='/data/game/01_douDiZhu/ZOO_LOG'
glog_patch01='/data/game_zip_log/zoo'

##today
tar -zcvf $glog_patch01/01_ddz/99_ddz_"$daysa".tar.gz -C $log_patch01 $days
