#!/bin/bash

app01="/home/qwer99/game_log_app/01CountScore"
app02="/home/qwer99/game_log_app/02CountScore"
app03="/home/qwer99/game_log_app/03CountScore"
app04="/home/qwer99/game_log_app/04CountScore"
app05="/home/qwer99/game_log_app/05CountScore"
app06="/home/qwer99/game_log_app/06CountScore"
app07="/home/qwer99/game_log_app/07CountScore"
app08="/home/qwer99/game_log_app/08CountScore"
app09="/home/qwer99/game_log_app/09CountScore"
app10="/home/qwer99/game_log_app/10CountScore"

zo_log_patch='/data/game_zip_log/zoo'

##today
days=`date --date='1 days ago' "+%Y_%m_%d"`
daysa=`date --date='0 days ago' "+%Y%m%d"`


mkdir -p "$zo_log_patch/01_ddz/$days"
mkdir -p "$zo_log_patch/02_pdk/$days"
mkdir -p "$zo_log_patch/03_zjh/$days"
mkdir -p "$zo_log_patch/04_dzpk/$days"
mkdir -p "$zo_log_patch/05_dn/$days"
mkdir -p "$zo_log_patch/06_dnbr/$days"
mkdir -p "$zo_log_patch/07_bcbm/$days"
mkdir -p "$zo_log_patch/08_lhd/$days"
mkdir -p "$zo_log_patch/09_hhdz/$days"
mkdir -p "$zo_log_patch/10_bjl/$days"


##ddz log patch
log_patch01="/data/game/01_douDiZhu/ZOO_LOG/$days"
glog_patch01="$zo_log_patch/01_ddz/$days"

##pdk log patch
log_patch02="/data/game/02_paoDeKuai/ZOO_LOG/$days"
glog_patch02="$zo_log_patch/02_pdk/$days"

##zjh log patch
log_patch03="/data/game/03_zhaJinHua/ZOO_LOG/$days"
glog_patch03="$zo_log_patch/03_zjh/$days"

##dzpk log patch
log_patch04="/data/game/04_deZhouPuKe/ZOO_LOG/$days"
glog_patch04="$zo_log_patch/04_dzpk/$days"

##dn log patch
log_patch05="/data/game/05_dn_qiangZhuang/ZOO_LOG/$days"
glog_patch05="$zo_log_patch/05_dn/$days"

##dnbr log patch
log_patch06="/data/game/06_dn_baiRen/ZOO_LOG/$days"
glog_patch06="$zo_log_patch/06_dnbr/$days"

##bcbm log patch
log_patch07="/data/game/07_benChiBaoMa/ZOO_LOG/$days"
glog_patch07="$zo_log_patch/07_bcbm/$days"

##lhd log patch
log_patch08="/data/game/08_longHuDou/ZOO_LOG/$days"
glog_patch08="$zo_log_patch/08_lhd/$days"

##hhdz log patch
log_patch09="/data/game/09_hongHeiDaZhan/ZOO_LOG/$days"
glog_patch09="$zo_log_patch/09_hhdz/$days"

##bjl log patch
log_patch10="/data/game/10_baiJiaLe/ZOO_LOG/$days"
glog_patch10="$zo_log_patch/10_bjl/$days"


##ddz today

$app01 "$log_patch01/DDZ_Room_001.log_$days.txt" $glog_patch01
$app01 "$log_patch01/DDZ_Room_100.log_$days.txt" $glog_patch01
$app01 "$log_patch01/DDZ_Room_200.log_$days.txt" $glog_patch01

##pdk today

$app02 "$log_patch02/PDK_Room_001.log_$days.txt" $glog_patch02
$app02 "$log_patch02/PDK_Room_100.log_$days.txt" $glog_patch02
$app02 "$log_patch02/PDK_Room_200.log_$days.txt" $glog_patch02

##zjh today

$app03 "$log_patch03/ZJH_Room_001.log_$days.txt" $glog_patch03
$app03 "$log_patch03/ZJH_Room_100.log_$days.txt" $glog_patch03
$app03 "$log_patch03/ZJH_Room_200.log_$days.txt" $glog_patch03
$app03 "$log_patch03/ZJH_Room_002.log_$days.txt" $glog_patch03


##dzpk today

$app04 "$log_patch04/DZPK_Room_001.log_$days.txt" $glog_patch04
$app04 "$log_patch04/DZPK_Room_005.log_$days.txt" $glog_patch04
$app04 "$log_patch04/DZPK_Room_025.log_$days.txt" $glog_patch04
$app04 "$log_patch04/DZPK_Room_050.log_$days.txt" $glog_patch04

##dn today

$app05 "$log_patch05/DN_Room_001.log_$days.txt" $glog_patch05
$app05 "$log_patch05/DN_Room_100.log_$days.txt" $glog_patch05
$app05 "$log_patch05/DN_Room_200.log_$days.txt" $glog_patch05


##dnbr today

$app06 "$log_patch06/DNBR_Room_001.log_$days.txt" $glog_patch06
$app06 "$log_patch06/DNBR_Room_100.log_$days.txt" $glog_patch06
$app06 "$log_patch06/DNBR_Room_200.log_$days.txt" $glog_patch06


##bcbm today

$app07 "$log_patch07/BCBM_Room_001.log_$days.txt" $glog_patch07
$app07 "$log_patch07/BCBM_Room_100.log_$days.txt" $glog_patch07
$app07 "$log_patch07/BCBM_Room_200.log_$days.txt" $glog_patch07


##lhd today

$app08 "$log_patch08/LHD_Room_001.log_$days.txt" $glog_patch08
$app08 "$log_patch08/LHD_Room_100.log_$days.txt" $glog_patch08
$app08 "$log_patch08/LHD_Room_200.log_$days.txt" $glog_patch08


##hhdz today

$app09 "$log_patch09/HHDZ_Room_001.log_$days.txt" $glog_patch09
$app09 "$log_patch09/HHDZ_Room_100.log_$days.txt" $glog_patch09
$app09 "$log_patch09/HHDZ_Room_200.log_$days.txt" $glog_patch09


##bjl today

$app10 "$log_patch10/BJL_Room_001.log_$days.txt" $glog_patch10
$app10 "$log_patch10/BJL_Room_100.log_$days.txt" $glog_patch10
$app10 "$log_patch10/BJL_Room_200.log_$days.txt" $glog_patch10


