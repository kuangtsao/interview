#!/bin/bash
curl -s -X POST https://api.telegram.org/[telegram bot token]/sendMessage \
-d chat_id=-402903799 \
-d text="===每日例會通知===  
          0945 開會"
