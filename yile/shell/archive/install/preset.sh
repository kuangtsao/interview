#!/bin/bash
#Description: preset
#Date:        2021-05-06
#Os:          Amazon linux 2
#Author:      Marcus
#Run user:    ec2-user
set -x
user=$(whoami)

if [ $user != 'root' ]; then
echo "run the script with sudo or switch user to root "
exit 0
fi
cd /
mkdir data
pvcreate /dev/xvdb
vgcreate data /dev/xvdb
lvcreate -l 100%FREE -n data data
mkfs.xfs /dev/data/data
echo '/dev/data/data /data xfs defaults 0 0' > /etc/fstab
mount -a