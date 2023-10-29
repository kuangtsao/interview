#!/bin/bash

days=90
log_patch=/data/deploy

find $log_patch/01_douDiZhu/logs -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/02_paoDeKuai/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/3_zhaJinHua/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/4_deZhouPuKe/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/5_dn_qiangZhuang/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/06_dn_baiRen/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/7_benChiBaoMa/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/8_longHuDou/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/9_hongHeiDaZhan/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;
find $log_patch/10_baiJiaLe/logs  -mtime +$days -name "*.log" -exec rm -rf {} \;

