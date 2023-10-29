#!/bin/bash

app01="/home/qpdevops/test/01CountScore"
app02="/home/qpdevops/test/02CountScore"
app03="/home/qpdevops/test/03CountScore"
app04="/home/qpdevops/test/04CountScore"
app05="/home/qpdevops/test/05CountScore"
app06="/home/qpdevops/test/06CountScore"
app07="/home/qpdevops/test/07CountScore"
app08="/home/qpdevops/test/08CountScore"
app09="/home/qpdevops/test/09CountScore"
app10="/home/qpdevops/test/10CountScore"

##today
days=`date --date='0 days ago' "+%Y_%m_%d"`
daysa=`date --date='0 days ago' "+%Y%m%d"`

mkdir -p "/data/game_zip_log/zoo/01_ddz/$days"
mkdir -p "/data/game_zip_log/zoo/02_pdk/$days"
mkdir -p "/data/game_zip_log/zoo/03_zjh/$days"
mkdir -p "/data/game_zip_log/zoo/04_dzpk/$days"
mkdir -p "/data/game_zip_log/zoo/05_dn/$days"
mkdir -p "/data/game_zip_log/zoo/06_dnbr/$days"
mkdir -p "/data/game_zip_log/zoo/07_bcbm/$days"
mkdir -p "/data/game_zip_log/zoo/08_lhd/$days"
mkdir -p "/data/game_zip_log/zoo/09_hhdz/$days"
mkdir -p "/data/game_zip_log/zoo/10_bjl/$days"

##ddz log patch
log_patch01="/data/deploy/01_douDiZhu/ZOO_LOG/$days"
glog_patch01="/data/game_zip_log/zoo/01_ddz/$days"

##pdk log patch
log_patch02="/data/deploy/02_paoDeKuai/ZOO_LOG/$days"
glog_patch02="/data/game_zip_log/zoo/02_pdk/$days"

##zjh log patch
log_patch03="/data/deploy/3_zhaJinHua/ZOO_LOG/$days"
glog_patch03="/data/game_zip_log/zoo/03_zjh/$days"

##dzpk log patch
log_patch04="/data/deploy/4_deZhouPuKe/ZOO_LOG/$days"
glog_patch04="/data/game_zip_log/zoo/04_dzpk/$days"

##dn log patch
log_patch05="/data/deploy/5_dn_qiangZhuang/ZOO_LOG/$days"
glog_patch05="/data/game_zip_log/zoo/05_dn/$days"

##dnbr log patch
log_patch06="/data/deploy/06_dn_baiRen/ZOO_LOG/$days"
glog_patch06="/data/game_zip_log/zoo/06_dnbr/$days"

##dzpk log patch
log_patch07="/data/deploy/7_benChiBaoMa/ZOO_LOG/$days"
glog_patch07="/data/game_zip_log/zoo/04_dzpk/$days"

##lhd log patch
log_patch08="/data/deploy/8_longHuDou/ZOO_LOG/$days"
glog_patch08="/data/game_zip_log/zoo/08_lhd/$days"

##hhdz log patch
log_patch09="/data/deploy/9_hongHeiDaZhan/ZOO_LOG/$days"
glog_patch09="/data/game_zip_log/zoo/09_hhdz/$days"

##bjl log patch
log_patch10="/data/deploy/10_baiJiaLe/ZOO_LOG/$days"
glog_patch10="/data/game_zip_log/zoo/10_bjl/$days"


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
$app03 "$log_patch03/ZJH_Room_002.log_$days.txt" $glog_patch03
$app03 "$log_patch03/ZJH_Room_100.log_$days.txt" $glog_patch03
$app03 "$log_patch03/ZJH_Room_200.log_$days.txt" $glog_patch03

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


#tar -zcvf $glog_patch01/01_ddz/99_ddz_"$daysa".tar.gz -C $log_patch01 $days

#tar -zcvf $glog_patch01/01_ddz/99_ddz_"$daysa".tar.gz -C $log_patch01 $days
