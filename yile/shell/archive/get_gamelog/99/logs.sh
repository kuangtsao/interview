if [ -d "/tmp/gamelog" ];
then
 echo "刪除舊 log"
 rm -rf /tmp/gamelog
fi

while read dir
do
 touch $dir
 ls /data/game/$dir/logs > ./$dir
done < ./logdir

while read process
do
 mkdir -p /tmp/gamelog/01_douDiZhu/logs/$process
 cp /data/game/01_douDiZhu/logs/$process/log/nml/20210305.log  /tmp/gamelog/01_douDiZhu/logs/$process
done < ./01_douDiZhu

while read process
do
 mkdir -p /tmp/gamelog/02_paoDeKuai/logs/$process
 cp /data/game/02_paoDeKuai/logs/$process/log/nml/20210305.log  /tmp/gamelog/02_paoDeKuai/logs/$process
done < ./02_paoDeKuai

while read process
do
 mkdir -p /tmp/gamelog/06_dn_baiRen/logs/$process
 cp /data/game/06_dn_baiRen/logs/$process/log/nml/20210305.log  /tmp/gamelog/06_dn_baiRen/logs/$process
done < ./06_dn_baiRen

while read process
do
 mkdir -p /tmp/gamelog/10_baiJiaLe/logs/$process
 cp /data/game/10_baiJiaLe/logs/$process/log/nml/20210305.log  /tmp/gamelog/10_baiJiaLe/logs/$process
done < ./10_baiJiaLe

while read process
do
 mkdir -p /tmp/gamelog/03_zhaJinHua/logs/$process
 cp /data/game/03_zhaJinHua/logs/$process/log/nml/20210305.log  /tmp/gamelog/03_zhaJinHua/logs/$process
done < ./03_zhaJinHua

while read process
do
 mkdir -p /tmp/gamelog/04_deZhouPuKe/logs/$process
 cp /data/game/04_deZhouPuKe/logs/$process/log/nml/20210305.log  /tmp/gamelog/04_deZhouPuKe/logs/$process
done < ./04_deZhouPuKe

while read process
do
 mkdir -p /tmp/gamelog/05_dn_qiangZhuang/logs/$process
 cp /data/game/05_dn_qiangZhuang/logs/$process/log/nml/20210305.log  /tmp/gamelog/05_dn_qiangZhuang/logs/$process
done < ./05_dn_qiangZhuang

while read process
do
 mkdir -p /tmp/gamelog/07_benChiBaoMa/logs/$process
 cp /data/game/07_benChiBaoMa/logs/$process/log/nml/20210305.log  /tmp/gamelog/07_benChiBaoMa/logs/$process

done < ./07_benChiBaoMa

while read process
do
 mkdir -p /tmp/gamelog/08_longHuDou/logs/$process
 cp /data/game/08_longHuDou/logs/$process/log/nml/20210305.log  /tmp/gamelog/08_longHuDou/logs/$process
done < ./08_longHuDou

while read process
do
 mkdir -p /tmp/gamelog/09_hongHeiDaZhan/logs/$process
 cp /data/game/09_hongHeiDaZhan/logs/$process/log/nml/20210305.log  /tmp/gamelog/09_hongHeiDaZhan/logs/$process
done < ./09_hongHeiDaZhan


