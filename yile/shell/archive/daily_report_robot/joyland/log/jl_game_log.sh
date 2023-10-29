#!/bin/bash

##01_douDiZhu鬥地主##
game1_path='/data/deploy/01_douDiZhu'

find "$game1_path/logs/ddz_cfgArea84/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game1_path/logs/ddz_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game1_path/logs/ddz_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game1_path/ZOO_LOG/" -mtime +60 -type d -exec rm -rf {} \;

##02_paoDeKuai跑得快##
game2_path='/data/deploy/02_paoDeKuai'

find "$game2_path/logs/pdk_cfgArea84/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game2_path/logs/pdk_cfgArea85/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game2_path/logs/pdk_cfgArea86/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game2_path/logs/pdk_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game2_path/logs/pdk_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game2_path/ZOO_LOG/" -mtime +60 -type d -exec rm -rf {} \;


##3_zhaJinHua炸金花##
game3_path='/data/deploy/3_zhaJinHua'

find "$game3_path/logs/zjh_cfgArea8011101/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game3_path/logs/zjh_cfgArea8011201/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game3_path/logs/zjh_cfgArea8011301/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game3_path/logs/zjh_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game3_path/logs/zjh_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##4_deZhouPuKe德州撲克##
game4_path='/data/deploy/4_deZhouPuKe'

find "$game4_path/logs/dzpk_cfgArea4000/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game4_path/logs/dzpk_cfgArea4001/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game4_path/logs/dzpk_cfgArea4002/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game4_path/logs/dzpk_cfgArea4003/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game4_path/logs/dzpk_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game4_path/logs/dzpk_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##5_dn_qiangZhuang搶庄牛牛##
game5_path='/data/deploy/5_dn_qiangZhuang'

find "$game5_path/logs/dn_AreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game5_path/logs/dn_DbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game5_path/logs/dn_cfgArea84/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game5_path/logs/dn_cfgArea85/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game5_path/logs/dn_cfgArea86/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game5_path/ZOO_LOG/" -mtime +60 -type d -exec rm -rf {} \;

##06_dn_baiRen百人牛牛##
game6_path='/data/deploy/06_dn_baiRen'

find "$game6_path/logs/dnbr_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game6_path/logs/dnbr_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game6_path/logs/dnbr_cfgArea83/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game6_path/logs/dnbr_cfgArea84/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game6_path/ZOO_LOG/" -mtime +60 -type d -exec rm -rf {} \;

##7_benChiBaoMa奔馳寶馬##
game7_path='/data/deploy/7_benChiBaoMa'

find "$game7_path/logs/bcbm_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game7_path/logs/bcbm_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game7_path/logs/bcbm_cfgArea701010/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##8_longHuDou龍虎鬥##
game8_path='/data/deploy/8_longHuDou'

find "$game8_path/logs/lhd_AreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game8_path/logs/lhd_DbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game8_path/logs/lhd_cfgArea801010/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##9_hongHeiDaZhan紅黑大戰##
game9_path='/data/deploy/9_hongHeiDaZhan'

find "$game9_path/logs/hhdz_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game9_path/logs/hhdz_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game9_path/logs/hhdz_cfgArea901010/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##10_baiJiaLe百家樂##
game10_path='/data/deploy/10_baiJiaLe'

find "$game10_path/logs/bjl_cfgAreaMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game10_path/logs/bjl_cfgDbMgr/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;
find "$game10_path/logs/bjl_cfgArea1001010/log/nml/" -mtime +60 -type f -name "*.log" -exec rm -rf {} \;

##每天的凌晨3點執行此腳本##
# crontab -e;
# 0 3 * * * /home/qpdevops/bash/log/jl_game_log.sh;

