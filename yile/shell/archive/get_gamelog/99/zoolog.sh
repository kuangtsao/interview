while read dir
do
 cp -r /data/game/$dir/ZOO_LOG/2021_03_05/ /tmp/gamelog/$dir/ZOO_LOG
done < ./logdir
