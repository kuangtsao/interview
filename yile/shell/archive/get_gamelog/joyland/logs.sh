if [ -d "/tmp/gamelog" ];
then
 echo "刪除舊 log"
 rm -rf /tmp/gamelog
fi

while read dir
do
 touch $dir
 ls /data/deploy/$dir/logs > ./$dir
done < ./logdir

while read process
do
 mkdir -p /tmp/gamelog/01_douDiZhu/logs/$process
 cp /data/deploy/01_douDiZhu/logs/$process/log/nml/20210303.log  /tmp/gamelog/01_douDiZhu/logs/$process
 cp /data/deploy/01_douDiZhu/logs/$process/log/nml/20210304.log  /tmp/gamelog/01_douDiZhu/logs/$process
done < ./01_douDiZhu


while read process
do
 mkdir -p /tmp/gamelog/02_paoDeKuai/logs/$process
 cp /data/deploy/02_paoDeKuai/logs/$process/log/nml/20210303.log  /tmp/gamelog/02_paoDeKuai/logs/$process

done < ./02_paoDeKuai

while read process
do
 mkdir -p /tmp/gamelog/06_dn_baiRen/logs/$process
 cp /data/deploy/06_dn_baiRen/logs/$process/log/nml/20210303.log  /tmp/gamelog/06_dn_baiRen/logs/$process
done < ./06_dn_baiRen

while read process
do
 mkdir -p /tmp/gamelog/10_baiJiaLe/logs/$process
 cp /data/deploy/10_baiJiaLe/logs/$process/log/nml/20210303.log  /tmp/gamelog/10_baiJiaLe/logs/$process
done < ./10_baiJiaLe

while read process
do
 mkdir -p /tmp/gamelog/3_zhaJinHua/logs/$process
 cp /data/deploy/3_zhaJinHua/logs/$process/log/nml/20210303.log  /tmp/gamelog/3_zhaJinHua/logs/$process
done < ./3_zhaJinHua

while read process
do
 mkdir -p /tmp/gamelog/4_deZhouPuKe/logs/$process
 cp /data/deploy/4_deZhouPuKe/logs/$process/log/nml/20210303.log  /tmp/gamelog/4_deZhouPuKe/logs/$process
done < ./4_deZhouPuKe

while read process
do
 mkdir -p /tmp/gamelog/5_dn_qiangZhuang/logs/$process
 cp /data/deploy/5_dn_qiangZhuang/logs/$process/log/nml/20210303.log  /tmp/gamelog/5_dn_qiangZhuang/logs/$process

done < ./5_dn_qiangZhuang

while read process
do
 mkdir -p /tmp/gamelog/7_benChiBaoMa/logs/$process
 cp /data/deploy/7_benChiBaoMa/logs/$process/log/nml/20210303.log  /tmp/gamelog/7_benChiBaoMa/logs/$process
done < ./7_benChiBaoMa

while read process
do
 mkdir -p /tmp/gamelog/8_longHuDou/logs/$process
 cp /data/deploy/8_longHuDou/logs/$process/log/nml/20210303.log  /tmp/gamelog/8_longHuDou/logs/$process

done < ./8_longHuDou

while read process
do
 mkdir -p /tmp/gamelog/9_hongHeiDaZhan/logs/$process
 cp /data/deploy/9_hongHeiDaZhan/logs/$process/log/nml/20210303.log  /tmp/gamelog/9_hongHeiDaZhan/logs/$process
done < ./9_hongHeiDaZhan



