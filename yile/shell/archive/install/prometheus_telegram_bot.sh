#!/bin/bash
#Description: install prometheus telegram bot
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
wget https://github.com/inCaller/prometheus_bot/archive/refs/heads/master.zip
mv prometheus_bot-master prometheus_bot
mkdir -p /data/prometheus_bot/config
touch /data/prometheus_bot/config/config.yaml
cat > /data/prometheus_bot/config/config.yaml << 'EOF'
telegram_token: "<insert bot token here>"
template_path: "/data/prometheus-bot/config/template.tmpl"
time_zone: "Asia/Taipei" #tz database time zones
time_outdata: "2006/02/01 15:04:05"
split_token: "|"
EOF
touch /data/prometheus_bot/config/template.tmpl
cat > /data/prometheus_bot/config/template.tmpl << 'EOF'
Type: {{.CommonAnnotations.description}}
Summary: {{.CommonAnnotations.summary}}
Alertname: {{ .CommonLabels.alertname }}
Instance: {{ .CommonLabels.instance }}
Serverity: {{ .CommonLabels.serverity}}
Status:  {{ .Status }}
EOF
cd /data/prometheus_bot
export GOPATH="/data/go/bin"
make clean
make
chown -R prometheus:prometheus prometheus_bot/

cat > /etc/systemd/system/prometheus_bot.service << 'EOF'
[Unit]
Description=prometheus telegram bot
Documention=https://github.com/inCaller/prometheus_bot/blob/master/README.md
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/data/prometheus_bot/prometheus_bot

[Install]
WantedBy=multi-user.target

EOF

systemctl daemon-reload
systemctl enable prometheus_bot
echo "please check config.yaml in /data/prometheus_bot/config, set telegram token properly"
echo "please check template.tmpl in /data/prometheus_bot/config, check https://github.com/inCaller/prometheus_bot/blob/master/testdata/default.tmpl for setting alert message"
echo "check what prometheus alert message by run prometheus_bot directly,such as: './prometheus_bot -c /data/prometheus-bot/config/config.yaml -t /data/prometheus-bot/config/template.tmpl'"
echo "run prometheus_bot service with sudo systemctl start prometheus_bot"


