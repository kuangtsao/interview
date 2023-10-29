# <p align="center">TelegramBotAPI

<p align="center">A simple, but extensible Python implementation for the <a href="https://core.telegram.org/bots/api">Telegram Bot API</a>.

## 1. Getting started. (先安裝 python 版的 Telegram Bot API)

This API is tested with Python Python 3.6-3.9 and Pypy 3.
There are two ways to install the library:

* Installation python3 and pip3 git:

```
$ yum install epel-release

$ yum -y install python3-pip git
```

* Installation using pip (a Python package manager)*:

```
$ pip3 install pyTelegramBotAPI
```
* Installation from source (requires git):

```
$ git clone https://github.com/eternnoir/pyTelegramBotAPI.git
$ cd pyTelegramBotAPI
$ python3 setup.py install
```

It is generally recommended to use the first option.

**While the API is production-ready, it is still under development and it has regular updates, do not forget to update it regularly by calling 
`pip3 install pytelegrambotapi --upgrade`*

## Writing your first bot

### Prerequisites

It is presumed that you [have obtained an API token with @BotFather](https://core.telegram.org/bots#botfather). We will call this token `TOKEN`.
Furthermore, you have basic knowledge of the Python programming language and more importantly [the Telegram Bot API](https://core.telegram.org/bots/api).

```
要讓 bot 可以在 group 裡面可以回應，要透過 /mybots -> 選擇 bot -> Bot Settings -> Group Privacy -> 按下 Turn Off
(畫面顯示 Privacy mode is disabled for xxxx 就表示啟用了)
```

## 2. 開發程式下載

```
$ git clone git@gitlab.com:iac8/telegrambot.git
$ cd telegrambot
$ python3 tg_bot.py
```

## 3. systemd service

```
$ vi /etc/systemd/system/tg_bot.service

[Unit]
Description=taiwan yile service telegram bot

[Service]
Type=simple
ExecStart=/usr/bin/python3 /root/telegrambot/tg_bot.py
Restart=always

[Install]
WantedBy=multi-user.target

$ systemctl status tg_bot
$ systemctl stop tg_bot
$ systemctl start tg_bot
```
## 4. 部署
```
scp tg_bot.py root@172.17.1.185:/root/telegrambot
systemctl stop tg_bot
systemctl start tg_bot 
```