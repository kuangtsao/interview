# ansible_installscript

https://gitlab.com/iac8/elasticsearch 的安裝用 shell ansible 化


## 目錄架構

[官方目錄的最佳實踐](https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#directory-layout)

```
ansible_installscript
├── inventory
│   └── test
├── playbook
│   └── alertmanager.yml 
└── roles
    ├── alertmanager
    │   ├── files
    │   └── tasks
```

`inventory`: 照規劃而言是要放 host ip 資訊，目前是拿來放測試用的 VM 資訊  

一個 `package` 會對應到一個 `playbook` 和 一個 `role`

`playbook`：只用來叫 `role` 

`role`： 分為兩個部分，`tasks` 和 `files`：`tasks` 主要利用 playbook 會優先抓 role 底下的 main.yml 執行的特性，執行安裝流程；`files` 則是放需要的設定檔，比如 systemd unit file。

可參考[官方說明檔](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) role directory structure 的說明

## 開發注意事項

* 請務必寫 playbook 的用法
* 需注意下面共同的使用環境變數
* README 的修改，確認過上傳上來的分支後，再交由參與者編輯後推上 master

### 共同使用的環境變數

* user_name : 使用者帳號

### ansible.cfg

* host_key_check false
* roles_path 抓相對的 roles 路徑，與在 172.17.1.80 的 `/data/ansible_installscript/roles`，主要是讓 ansible 可以去抓這些位置的 roles，可以正常執行。

可參考[官方說明檔](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) storing and finding roles 的部分

### 部署在 172.17.1.80 的注意事項

* 部署位置為 `/data/ansible_installscript`
* 更新方式為進入後手動 pull
* git 手動 Pull 完記得確認一下 owner 是不是 rundeck:rundeck
* 機器私鑰記得檢查是否在 `/var/lib/rundeck/.ssh` 或在 `/home/rundeck/.ssh/` 裡面

## ansible playbook 使用說明

-i 後面的逗號是一定要加的，原因是為了可以不經過載入 inventory file 的方式，直接餵入 IP 使用。

### manage_users

安裝必要套件與調整 kernal

```
ansible-playbook playbook/init.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

添加使用者帳號

```
ansible-playbook playbook/manage_users.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

創建LVM

```
ansible-playbook playbook/lvm.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] disk_name=[sd* or xvd*] user_name=[user]' -i [機器對外 IP],
```

創建目錄

```
ansible-playbook playbook/create_dir.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[user]' -i [機器對外 IP],
```

JAVA安裝

```
ansible-playbook playbook/java.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

go 安裝

version 請查看 download server 上有的版本(目前有 1.16.4 和 1.16.5)

```
ansible-playbook playbook/go.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] version=[version]' -i [機器對外 IP],
```

php 安裝
```
ansible-playbook playbook/php.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

node_exporter 安裝

```
ansible-playbook playbook/node_exporter.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```
prometheus 安裝

```
ansible-playbook playbook/prometheus.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

alertmanager 安裝
```
ansible-playbook playbook/alertmanager.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

grafana 安裝
```
ansible-playbook playbook/grafana.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

prometheus_bot 安裝
```
ansible-playbook playbook/prometheus_bot.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

Openresty安裝

```
ansible-playbook playbook/openresty.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```
tomcat安裝

```
ansible-playbook playbook/tomcat.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

filebeat安裝

```
ansible-playbook playbook/filebeat.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username] redis_ip=[ip]' -i [機器對外 IP],
```

zookeeeper 安裝

```
ansible-playbook playbook/zookeeper.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

kafka 安裝

```
ansible-playbook playbook/kafka.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

kafka_exporter 安裝
```
ansible-playbook playbook/kafka_exporter.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

mysql 安裝
```
ansible-playbook playbook/mysql.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

xtrabackup 安裝
```
ansible-playbook playbook/xtrabackup.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

redis 安裝
```
ansible-playbook playbook/redis.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

elasticsearch 安裝
```
ansible-playbook playbook/elasticsearch.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]'
```

logstash 安裝
```
ansible-playbook playbook/logstash.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

kibana 安裝
```
ansible-playbook playbook/kibana.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

elastic alert 安裝
```
ansible-playbook playbook/elasticalert.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

mongodb 安裝
```
ansible-playbook playbook/mongodb.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```
mysqld_exporter 安裝
```
ansible-playbook playbook/mysqld_exporter.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user]' -i [機器對外 IP],
```

blackbox_exporter 安裝
```
ansible-playbook playbook/blackbox_exporter.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

redis_exporter 安裝
```
ansible-playbook playbook/redis_exporter.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

orion 安裝
* test_url = 輸入需要測試的硬碟掛載位置

```
ansible-playbook playbook/orion.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] test_url=[/dev/mapper/centos-root]' -i [機器對外 IP],
```

loki 安裝
```
ansible-playbook playbook/loki.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

promtail 安裝
```
ansible-playbook playbook/promtail.yml  -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

rabbitmq 安裝
```
ansible-playbook playbook/rabbitmq.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```

rocketmq 安裝
```
ansible-playbook playbook/rocketmq.yml -e 'ansible_host=[機器對外 IP] ansible_user=[可以使用 sudo 的 user] user_name=[username]' -i [機器對外 IP],
```
