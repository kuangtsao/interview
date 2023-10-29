#!/bin/bash
#Description: prometheus v2.26.0
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
useradd --no-create-home --shell /sbin/nologin prometheus
cd /data
wget https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
tar zxf prometheus-2.26.0.linux-amd64.tar.gz
mv prometheus-2.26.0.linux-amd64 prometheus
mkdir -p /data/prometheus/tsdb
chown -R prometheus:prometheus /data/prometheus
ln -s /data/prometheus/promtool /usr/bin/promtool
touch /etc/systemd/system/prometheus.service
cat > /etc/systemd/system/prometheus.service << 'EOF'
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/data/prometheus/prometheus \
    --config.file /data/prometheus/prometheus.yml \
    --storage.tsdb.path /data/prometheus/tsdb \
    --web.console.templates=/data/prometheus/consoles \
    --web.console.libraries=/data/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

cat > /data/prometheus/prometheus.yml << 'EOF'
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets: ['localhost:9093']

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    scrape_interval: 5s
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
    - targets: ['localhost:9100']
EOF

rm -f prometheus-2.26.0.linux-amd64.tar.gz
systemctl daemon-reload
systemctl enable prometheus
echo "run prometheus service with sudo systemctl start prometheus"
echo "access prometheus via http://$myip:9090"