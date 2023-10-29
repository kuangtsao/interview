#!/bin/bash
#Description: alertmanager v0.21.0
#Date:        2021-05-06
#Os:          Amazon linux 2
#Author:      Marcus
#Run user:    ec2-user
user=$(whoami)
myip=$(curl -s https://whatismyip.akamai.com)

if [ $user != 'root' ]; then
echo "run the script with sudo or switch user to root "
exit 0
fi
useradd --no-create-home --shell /sbin/nologin alertmanager
cd /data
wget https://github.com/prometheus/alertmanager/releases/download/v0.21.0/alertmanager-0.21.0.linux-amd64.tar.gz
tar zxf alertmanager-0.21.0.linux-amd64.tar.gz
mv alertmanager-0.21.0.linux-amd64 alertmanager
chown -R alertmanager:alertmanager /data/alertmanager
ln -s /data/alertmanager/amtool /usr/bin/amtool
cat > /etc/systemd/system/alertmanager.service << 'EOF'
[Unit]
Description=Alertmanager

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/data/alertmanager/alertmanager --config.file=/data/alertmanager/alertmanager.yml --web.external-url http://0.0.0.0:9093

[Install]
WantedBy=multi-user.target
EOF
rm -f alertmanager-0.21.0.linux-amd64.tar.gz
systemctl daemon-reload
systemctl enable alertmanager
echo "run alertmanager service with sudo systemctl start alertmanager"
echo "access alertmanager at http://$myip:9093,remember to open firewall on aws."