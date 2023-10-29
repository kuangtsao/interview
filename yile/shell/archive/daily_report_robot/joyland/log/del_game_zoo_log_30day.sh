#!/bin/bash

days=30
daysa=90
log_patch=/data/deploy
glog_patch=/data/game_zip_log/zoo


find "$glog_patch/01_ddz" -mtime +$daysa -name "*.tar.gz" -exec rm -rf {} \;

find "$log_patch/01_douDiZhu/ZOO_LOG" -mtime +$days -name "*.log" -exec rmdir  {} \;
