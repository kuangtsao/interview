# ansible

利用 ansible 管理現有環境


## 前置作業
OS distribution: Linux(都可以，挑順手的，debian/ubuntu/fedora)  
windows 可裝 wsl2 執行，又或者跑 docker  
安裝以下套件：
 - python(2.7 跟 3.8，避免ㄧ些奇怪狀況)
 - pip
 - ansible v2.9.15
 - sshpass
 - 任何 ansible 跳出錯誤，說你缺的任何套件

## inventory

- inventory/B
  - 放置 B 組 server 有關設定
- inventory/C
  - 放置 C 組 server 有關設定

需要注意的是，`ansible_ssh_private_key_file` 目前路徑是指定在家目錄底下的 `.ssh` ，由於指定的是私鑰，需要從公槽的這些路徑拿  
  
各 server 需要用的私鑰可參考各個 yml 檔裡的 `ansible_ssh_private_key_file` 

私鑰可從[新人需知](https://www.notion.so/f397422c182343bba005a483380828ca)第 10 像可以看到怎麼掛載，務必掛載到以下路徑，不然不能用。
- C 組
  - /mnt/yile/ssh_key/C
- B 組
  - /mnt/yile/ssh_key/B   

## playbook/install/zabbix_agent2.yml
安裝 zabbix-agent2 套件  
更改 zabbix-agent2.conf 設定  

### B 組使用方式
```
ansible-playbook playbook/install/zabbix-agent2.yml -i inventory/B/demo.yml -e hosts_name=yg-t-game01
```

### C 組使用方式
```
ansible-playbook playbook/install/zabbix-agent2.yml -i inventory/C/demo.yml -e hosts_name=jl_test_game --ask-vault-pass
```
因為有利用 `ansible-vault` 來鎖住敏感資料，輸入之後會問密碼，不知道問 marcus  


## playbook/linux_administration/manage_user.yml
添加特定 user  
綁 ssh 公鑰  

### B 組使用方式
```
ansible-playbook playbook/linux_administration/manage_user.yml -i inventory/B/demo.yml -e hosts_name=yg-t-game01
```

### C 組使用方式
```
ansible-playbook playbook/linux_administration/manage_user.yml -i inventory/C/demo.yml -e hosts_name=jl_test_game --ask-vault-pass
```

## playbook/update/hotfix.yml
上傳 hotfix 檔案到指定 server  

**請注意，務必在更新前，修改 vars 裡面的各產品的參數檔**  
### C 組使用方式
- 99
```
ansible-playbook playbook/update/hotfix.yml -i inventory/C/99.yml -e hosts_name=99-patch -e product=99 -e version=1.23.4.5 -e bot=1 or 2 or 3 --ask-vault-pass
```
- 歡樂天地(jl,hltd,joyland)
```
ansible-playbook playbook/update/hotfix.yml -i inventory/C/hl-prd.yml -e hosts_name=jl-patch-02 -e product=JoyLand -e version=1.1.1.1 -e env=PRD -e bot=1 or 2 or 3 --ask-vault-pass
```

## playbook/update/application.yml
上傳 apk 檔案到指定 server  
**請注意，務必在更新前，修改 vars 裡面的各產品的參數檔**  

### C 組使用方式
- 99
```
ansible-playbook playbook/update/application.yml -i inventory/C/99.yml -e hosts_name=99-patch -e product=99 --ask-vault-pass
```
- 歡樂天地(jl,hltd,joyland)
```
ansible-playbook playbook/update/application.yml -i inventory/C/hl-prd.yml -e hosts_name=jl-patch-02 -e product=joyland -e env=PRD --ask-vault-pass
```

## playbook/update/landing_page.yml
產生需要的落地頁的 html，不含裡面的 js 與圖片
**請注意，務必在更新前，修改 vars 裡面的各產品的參數檔**  

### C 組使用方式
- 99
```
ansible-playbook playbook/update/landing_page.yml -i inventory/C/99.yml -e hosts_name=99-webpage -e product=99 --ask-vault-pass
```
- 歡樂天地(jl,hltd,joyland)
```
ansible-playbook playbook/update/landing_page.yml -i inventory/C/hl-prd.yml -e hosts_name=jl-webpage -e product=joyland  --ask-vault-pass
```