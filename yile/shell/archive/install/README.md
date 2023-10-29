# 安裝 prometheus 系列的注意事項

1. 請務必先跑過 `preset.sh` 再接著下去跑其他的 shell，除非你很確定目標機的 `/data` 已經掛好額外的硬碟

2. 裡面的版本都是在當下(2021/05/12 前後)找到的最新版

3. 請依照你的實際狀況去改變裡面的任何設定

4. systemd unit file會在每個 shell 產生，執行指令都會在 systemd unit file 裡的 `ExecStart` 裡面

## preset.sh

請特別注意這是給 **`amazon linux 2`** 用的 script  
如果需要用再 centos 7`，請參考 [專用的 script](https://gitlab.com/iac8/disk_lvm/-/blob/leo/disk_lvm.sh)  

硬碟路徑的部分，有可能會是 `/dev/xvb1` 也有可能是 `/dev/nvme1n1`，請依據實際狀況做變動。

## prometheus.sh

做完之後，依據你需要的設定去調整 /data/prometheus/prometheus.yml

## node_exporter.sh

無特別需要注意的地方

## grafana.sh

無特別需要注意的地方

## alertmanager.sh

無特別需要注意的地方

## go_v1.16.4.sh

無特別需要注意的地方

## prometheus_telegram_bot.sh

相關設定請參考 [這個連結](https://github.com/inCaller/prometheus_bot/blob/master/README.md)


