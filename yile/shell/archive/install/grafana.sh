#!/bin/bash
#Description: alertmanager v2.26.0
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
useradd --no-create-home --shell /sbin/nologin grafana
cd /data
wget https://dl.grafana.com/oss/release/grafana-7.5.5.linux-amd64.tar.gz
tar zxf grafana-7.5.5.linux-amd64.tar.gz
mv grafana-7.5.5 grafana
mkdir -p /data/grafana/logs
mkdir -p /data/grafana/lib
cp /data/grafana/conf/defaults.ini /data/grafana/conf/grafana.ini # 不要用 mv，會讓 grafana 起不來
chown -R grafana:grafana /data/grafana
ln -s /data/grafana/bin/grafana-cli /usr/bin/grafana-cli
touch /etc/systemd/system/grafana.service
cat > /etc/systemd/system/grafana.service << 'EOF'
[Unit]
Description=Grafana instance
Documentation=http://docs.grafana.org

[Service]
User=grafana
Group=grafana
Type=notify
Restart=on-failure
WorkingDirectory=/data/grafana
RuntimeDirectory=grafana
RuntimeDirectoryMode=0750
ExecStart=/data/grafana/bin/grafana-server                                                        \
                            --config=/data/grafana/conf/grafana.ini                               \
                            --pidfile=/var/run/grafana/grafana.pid                                \
                            cfg:default.paths.logs=/data/grafana/logs                             \
                            cfg:default.paths.data=/data/grafana/lib                              \
                            cfg:default.paths.plugins=/data/grafana/conf/provisioning/plugins     \
                            cfg:default.paths.provisioning=/data/grafana/conf/provisioning

LimitNOFILE=10000
TimeoutStopSec=20

[Install]
WantedBy=multi-user.target
EOF

rm -f grafana-7.5.5.linux-amd64.tar.gz
systemctl daemon-reload
systemctl enable grafana
echo "run grafana service with sudo systemctl start grafana"
echo "access alertmanager at http://$myip:3000,remember to open firewall on aws."
echo "default acc/pw is admin/admin,after login,grafana will ask you change password,please record the password you change."