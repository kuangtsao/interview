while read dir
do
 cp -r /data/deploy/$dir/ZOO_LOG/2021_03_03/ /tmp/gamelog/$dir/ZOO_LOG/
 cp -r /data/deploy/$dir/ZOO_LOG/2021_03_04/ /tmp/gamelog/$dir/ZOO_LOG/
done < ./logdir
