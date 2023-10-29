#!/bin/bash
#Description: install go for compile
#Date:        2021-05-12
#Os:          Amazon linux 2
#Author:      Marcus
#Run user:    ec2-user
set -x
user=$(whoami)

if [ $user != 'root' ]; then
echo "run the script with sudo or switch user to root "
exit 0
fi
cd /data
wget https://golang.org/dl/go1.16.4.linux-amd64.tar.gz
tar zxvf go1.16.4.linux-amd64.tar.gz
ln -s /data/go/bin/go /usr/bin/go

check_go_install_properly=$(go version)
go version

if [ $check_go_install_properly != 'go version go1.16.4 linux/amd64' ]; then
echo "go doesn't install properly,pls check"
exit 0
else
echo "go install properly"
fi