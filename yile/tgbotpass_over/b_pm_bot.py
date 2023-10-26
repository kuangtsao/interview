#!/usr/bin/python

import telebot
import datetime
import requests
import json
import time
import lib.B_tools as tools
import lib.B_buttons as buttons
import actions.b_update_h5 as b_update_h5
import actions.b_update_svn as b_update_svn
import actions.b_start_game as b_start_game

API_TOKEN = '[telegram token]'

bot = telebot.TeleBot(API_TOKEN)


# Handle '/start' and '/help'
@bot.message_handler(commands=['help', 'start'])
def send_welcome(message):
    bot.reply_to(message, """\
相關指令如下：   \r\n \
\r\n
/update_svn 更新 B 組所有 server release 檔案(需要多拿版號)\r\n \
/start_games 開啟 B 組環境遊戲(需要多)\r\n \
/update_H5 更新 B 組 H5 \r\n \
""")

conversations = {}
user_list=[user1,user2,user3]
jenkins_robot_config = ('botacc','[jenkins token]')
jenkins_robot= {"config": jenkins_robot_config, "bot_to": "2"}


#更新 H5 服務
def callUpdateH5ServiceAction(enviorment):

    switcher = {
                 "UAT": b_update_h5.uat,
                 "DEMO": b_update_h5.demo,
                 "PRD": b_update_h5.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

#更新 SVN
def callUpdateSvnAction(enviorment):

    switcher = {
                 "UAT": b_update_svn.uat,
                 "DEMO": b_update_svn.demo,
                 "PRD": b_update_svn.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStartGameAction(enviorment):
    switcher = {
                 "UAT": b_start_game.uat,
                 "DEMO": b_start_game.demo,
                 "PRD": b_start_game.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

@bot.callback_query_handler(func=lambda call: True)
def callback_query(call):
    print('in callback_query')
    print(call.data)
    fromuser_id=str(call.data.split(":")[1])
    ans=call.data.split(":")[0]
    chat_id=conversations[fromuser_id]['chat_id']
    action=conversations[fromuser_id]['action']
    print("action: " + action)
    
    # 有需要多拿額外資訊的，就用 return 跳出，接其他函數的 yes/no；不需要的就用 ans 的 yes/no
    # 需要版號
    if ("UpdateH5" in call.data):
        enviorment=str(call.data.split(":")[0])
        conversations[fromuser_id]['enviorment']=enviorment
        msg = bot.send_message(conversations[fromuser_id]['chat_id'], "請輸入版號")
        bot.register_next_step_handler(msg, verification_step)
        return
    # 需要選擇全部與部分的按鈕
    if ("StartGame" in call.data):
        enviorment=str(call.data.split(":")[0])
        conversations[fromuser_id]['enviorment']=enviorment
        bot.send_message(conversations[fromuser_id]['chat_id'], "請選擇需要重開全部遊戲或部分遊戲(部分遊戲請先修改 games.txt 並推上 git)：",reply_markup=buttons.genAllorPartialMark(fromuser_id))
        return
    
    if ("all" in call.data) or ("partial" in call.data):
        mode=str(call.data.split(":")[0])
        conversations[fromuser_id]['mode']=mode

    # 不需額外資訊
    if  ("UpdateSvn" in call.data):
        enviorment=str(call.data.split(":")[0])
        conversations[fromuser_id]['enviorment']=enviorment

    if ans == "yes":
        if "/update_H5" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateH5ServiceAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_svn" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateSvnAction(enviorment)
            func(bot,jenkins_robot,chat_id)
        elif "/start_game" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            mode = conversations[fromuser_id]['mode']
            func = callStartGameAction(enviorment)
            func(bot,jenkins_robot,mode,chat_id)         
        else:
            bot.send_message(chat_id,"指令找不到，無法執行") 

        #選項移除方式
        bot.edit_message_text(
            text='請耐心等候',
            chat_id=chat_id,
            message_id=call.message.message_id,
        ) 

    elif ans == "no":
        msg = bot.send_message(chat_id, """\
        謝謝
""")
        bot.clear_step_handler(msg)
        bot.edit_message_text(
            text='bye',
            chat_id=chat_id,
            message_id=call.message.message_id,
        )
    
    else:
        bot.edit_message_text(
            text='確認執行以上動作？',
            chat_id=chat_id,
            message_id=call.message.message_id,reply_markup=buttons.genMarkup(fromuser_id)
        )
        bot.answer_callback_query(call.id, text='')
        return

    bot.answer_callback_query(call.id, text='')

def verification_step(message):
    # 這邊會收到一個新的 message
    # 動作會存在 conversations 的 action，所以可以用他來分動作，新的訊息可以另外 handle
    print('in verfication step')
    fromuser_id = str(message.from_user.id)
    action = conversations[fromuser_id]['action']
    print('action: ' + action)
    components = message.text
    print('components: ' + components)
    chat_id = conversations[fromuser_id]['chat_id']

    # 比較時間是否逾時
    now = datetime.datetime.now()
    expired = filter(lambda x: (now - conversations[x]['timestamp']).seconds > 20, conversations.keys())
    for chat in expired:
        print(conversations[chat])
        bot.send_message(conversations[chat]['chat_id'], 'timeout')
        bot.clear_step_handler(message)
        return

    # 逾時，以下就不執行
    try:
        conversations[fromuser_id]['version'] = components
        msg=bot.send_message(message.chat.id, "確認執行以上動作？", reply_markup=buttons.genMarkup(message.from_user.id))
    except Exception as e:
        print(e)
        bot.reply_to(message, 'oooops')



@bot.message_handler(commands=['update_H5'])
def update_H5_handler(message):

    conversations.clear()
    
    isvalid=tools.checkUser(message,user_list)

    if isvalid != 1:
        bot.send_message(message.chat.id, "你不是有權限的使用者！")
        return

    fromuser_id = str(message.from_user.id)
    conversations[fromuser_id] = {
        'timestamp': datetime.datetime.now(),
        'chat_id': message.chat.id,
        'action': message.text,
        'enviorment': '',
        'version': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateH5Mark(fromuser_id))

@bot.message_handler(commands=['update_svn'])
def update_svn_handler(message):

    conversations.clear()
    
    isvalid=tools.checkUser(message,user_list)

    if isvalid != 1:
        bot.send_message(message.chat.id, "你不是有權限的使用者！")
        return

    fromuser_id = str(message.from_user.id)
    conversations[fromuser_id] = {
        'timestamp': datetime.datetime.now(),
        'chat_id': message.chat.id,
        'action': message.text,
        'enviorment': '',
        'version': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateSvnMark(fromuser_id))
    

@bot.message_handler(commands=['start_games'])
def start_games_handler(message):

    conversations.clear()

    isvalid=tools.checkUser(message,user_list)

    if isvalid != 1:
        bot.send_message(message.chat.id, "你不是有權限的使用者！")
        return

    fromuser_id = str(message.from_user.id)
    conversations[fromuser_id] = {
        'timestamp': datetime.datetime.now(),
        'chat_id': message.chat.id,
        'action': message.text,
        'enviorment': '',
        'mode': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStartGameMark(fromuser_id))

bot.polling(none_stop=False, interval=0, timeout=20)
