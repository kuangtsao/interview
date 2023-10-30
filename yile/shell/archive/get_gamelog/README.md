# get_gamelog  
開發跟你要 log 時的簡易 shell 工具

## 架構
```
├── 99
│   ├── 01_douDiZhu
│   ├── 02_paoDeKuai
│   ├── 03_zhaJinHua
│   ├── 04_deZhouPuKe
│   ├── 05_dn_qiangZhuang
│   ├── 06_dn_baiRen
│   ├── 07_benChiBaoMa
│   ├── 08_longHuDou
│   ├── 09_hongHeiDaZhan
│   ├── 10_baiJiaLe
│   ├── logdir
│   ├── logs.sh
│   └── zoolog.sh
├── README.md
└── joyland
    ├── 01_douDiZhu
    ├── 02_paoDeKuai
    ├── 06_dn_baiRen
    ├── 10_baiJiaLe
    ├── 3_zhaJinHua
    ├── 4_deZhouPuKe
    ├── 5_dn_qiangZhuang
    ├── 7_benChiBaoMa
    ├── 8_longHuDou
    ├── 9_hongHeiDaZhan
    ├── createbymarcus
    ├── logdir
    ├── logs.sh
    └── zoolog.sh
```

## 概略說明

`logs.sh`：抓遊戲 log  
`zoolog.sh`：抓對戰類遊戲(如德州撲克)對戰過程的 log  
`遊戲名稱的檔案`：`logs.sh` 執行時會需要的檔案，裡面有紀錄 log 檔資料夾的資訊

歡樂天地部署路徑：`/home/qpdevops/bash/gamelog`  

久久部署路徑：`/home/qwer99/bash/gamelog`  

## 用法
- 開發會講他要哪個日期哪款遊戲的 log
- 先執行 `logs.sh` 再執行 `zoolog.sh`
- 之後進入 `/tmp/gamelog`，看到遊戲名稱的資料夾就是需要的 log，接著就可以打包了
- 若開發需要多個日期的 log，直接將抓 log 的 cp 指令複製多個，再執行即可。

## 更新

歡樂天地
```
$ rsync -avh [需更新的檔案] qpdevops@52.184.99.147:~/bash/gamelog/
```

久久
```
$ rsync -avh [需更新的檔案] qwer99@[host ip]:~/bash/gamelog/
```
## 作者
Marcus Liu(@lmarcus)
