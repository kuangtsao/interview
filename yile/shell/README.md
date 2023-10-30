# shell

放跑在機器上的 shell

## TODO
1. 整理各 shell 的用途
2. 備份目前在機器上的 shell

## 各 shell 的用途

1. `check_hall_file`
 - **已無用，移至 archive**
 - 沒有放在哪台機器
 - `hotfix` 更新時可使用的指令

2. `domain_check`
 - **目前已停止 cron job**
 - 目前在 `yile-zabbix` IP `172.17.1.185` 路徑 `/root/shell/domain_check`
 - 檢查 `DOMAIN` 底下的根域名的有效日期
 - DOMAIN 的資料來源
   - [JL Domain Dns Cdn]('不能給你看')
   - [99 Domain Dns Cdn]('不能給你看')
 - 方便更新上去的指令
```
scp DOMAINS root@172.17.1.185:/root/shell/domain_check
scp domain_check.sh root@172.17.1.185:/root/shell/domain_check
```
- cron job 設定
```
 root@yile-zabbix # crontab -l
 #0 8 * * * /root/shell/domain_check/domain_check.sh
```

3. `ssl_check`
 - **目前已停止 cron job**
 - 目前在 `yile-zabbix` IP `172.17.1.185` 路徑 `/root/shell/ssl_check`
 - 檢查 `DNS` 底下的域名的 SSL 有效日期
 - DNS 的資料來源
   - 各機組的 nginx config 檔
   - [JL Domain Dns Cdn]('不能給你看')
   - [99 Domain Dns Cdn]('不能給你看')
 - 方便更新上去的指令
 ```
 scp DNS root@172.17.1.185:/root/shell/ssl_check
 scp ssl_check.sh root@172.17.1.185:/root/shell/ssl_check
 ```
 - cron job 設定
```
 root@yile-zabbix # crontab -l
 #0 8 * * * /root/shell/domain_check/domain_check.sh
```


4. `daily_report_robot`
**已無用，移至 archive**

寫遊戲的人會看的輸贏報表，通常是 某些負責人 在看，若有需要入群看結果的找某個 PM

**如果是直接在 gameserver 上更新，請務必記得弄完抓下來，反之亦然**

- 程式架構
  - log/game_[today,yestday]_zoo_log.sh 會去叫 XXCountScore 產生今天或昨天的 log 到特定路徑  
  - bot 底下的會依據底分不同去撈特定路徑下的 zoolog，然後排版所需資料丟到 telegram 上面  
  - trigger 各個 shell 會需要去看各個 gameserver 的 crontab  
(待補完)

- 方便同步的指令(需要更新時)  
`99`:
```
rsync -avh qwer99@[host ip]:~/bash/bot [本地端放這專案的路徑]/shell/daily_report_robot/99
rsync -avh qwer99@[host ip]:~/bash/log [本地端放這專案的路徑]/shell/daily_report_robot/99
rsync -avh qwer99@[host ip]:~/bash/test [本地端放這專案的路徑]/shell/daily_report_robot/99
rsync -avh qwer99@[host ip]:~/game_log_app [本地端放這專案的路徑]/shell/daily_report_robot/99
```
`joyland`:
```
rsync -avh qpdevops@52.184.99.147:~/bash/log [本地端放這專案的路徑]/shell/daily_report_robot/joyland
rsync -avh qpdevops@52.184.99.147:~/test [本地端放這專案的路徑]/shell/daily_report_robot/joyland
rsync -avh qpdevops@52.184.99.147:~/bash/bot [本地端放這專案的路徑]/shell/daily_report_robot/joyland
```
5. get_gamelog  

- **已無用，移至 archive**
- 可參考[裡頭的說明](./get_gamelog/README.md)

6. install

- **已無用，移至 archive**
- 被 ansible_installscript 繼承了

7. b_jenkins

```
b_jenkins
├── configs
├── sample
├── start
├── stop
└── update
```
[Jenkins B 組更新]('jenkins 網址') 所有作業的 shell 存放處

`configs`： 舊設定取得地，已無用  
`sample`：`sample_b*` 開頭的 job 所使用的 shell，用來講解機器人用  
`start`：`B_*_START` 類型 job 所使用的 shell，開啟服務或遊戲使用  
`stop`：`B_*_STOP` 類型 job 所使用的 shell，關閉服務或遊戲使用
`update`：`B_*_UPDATE` 類型 job 所使用的 shell，更新服務與遊戲使用

### 使用注意事項

1. 遊戲類(start/games.sh,update/update_games.sh)在使用之前先去更新 `svn的 yg001 ./conf/list` 底下各環境的 `all_games.txt`，若有新增遊戲請記得添加。(`games.txt` 則由開發管理。)  

2. 後台類(update/update_agentbs.sh,update_authenticationapi.sh...)如果執行起來會怕的話，先去手動備份 `DEPLOY_PATH` 的資料夾。  

3. 這個有與更新機器人聯合使用，理論上手動執行也可以，但請務必把 **所有的 shell 看懂再手動執行**



8. b_update_script

B 組 gameserver 更新 script 的備份
