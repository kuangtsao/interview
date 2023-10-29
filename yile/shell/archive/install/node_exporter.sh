#!/bin/bash
#Description: node_exporter v1.1.2
#Date:        2021-05-06
#Os:          Amazon linux 2
#Author:      Marcus
#Run user:    ec2-user

user=$(whoami)

if [ $user != 'root' ]; then
echo "run the script with sudo or switch user to root "
exit 0
fi
useradd --no-create-home --shell /sbin/nologin node_exporter
cd /data
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
tar zxf node_exporter-1.1.2.linux-amd64.tar.gz
mv node_exporter-1.1.2.linux-amd64 node_exporter
chown -R node_exporter:node_exporter /data/node_exporter
touch /etc/systemd/system/node_exporter.service
cat > /etc/systemd/system/node_exporter.service << 'EOF'
[Unit]
Description=Node Exporter
Documention=https://github.com/prometheus/node_exporter/blob/master/README.md
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/data/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target

EOF
rm -f node_exporter-1.1.2.linux-amd64.tar.gz
systemctl daemon-reload
systemctl enable node_exporter
echo "run node_exporter service with sudo systemctl start node_exporter"
echo "access node_exporter via http://[external_ip/localhost]:9100"