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
import actions.b_update_api as b_update_api
import actions.b_update_game as b_update_game
import actions.b_update_gamelobby as b_update_gamelobby
import actions.b_update_central as b_update_central
import actions.b_update_lobby as b_update_lobby
import actions.b_update_agentbs as b_update_agentbs
import actions.b_update_developbs as b_update_developbs
import actions.b_update_middlewareapi as b_update_middlewareapi
import actions.b_update_authencationapi as b_update_authencationapi
import actions.b_update_gameresultapi as b_update_gameresultapi
import actions.b_update_thirdpartyapi as b_update_thirdpartyapi
import actions.b_stop_allgameserver as b_stop_allgameserver
import actions.b_stop_game as b_stop_game
import actions.b_stop_api as b_stop_api
import actions.b_start_service as b_start_service
import actions.b_start_api as b_start_api
import actions.b_start_game as b_start_game

API_TOKEN = '[telegram token]'

bot = telebot.TeleBot(API_TOKEN)


# Handle '/start' and '/help'
@bot.message_handler(commands=['help', 'start'])
def send_welcome(message):
    bot.reply_to(message, """\
相關指令如下：   \r\n \
\r\n
/update_svn 更新 B 組所有 server release 檔案\r\n \
\r\n
後台類： \r\n \
\r\n \
/update_agentbs 更新 B 組代理商\r\n \
/update_developbs 更新 B 組開發商\r\n \
/update_middlewareapi 更新 B 組 middleware api\r\n \
/update_authencationapi 更新 B 組 authencation api\r\n \
/update_gameresultapi 更新 B 組 gameresult api\r\n \
/update_thirdpartyapi 更新 B 組 thirdparty api\r\n \
\r\n \
遊戲與服務類： \r\n \
\r\n \
/stop_all_gameserver 關閉 B 組 gameserver 所有服務 \r\n \
/stop_game 關閉 B 組遊戲\r\n \
/stop_api 關閉 B 組 api\r\n \
/update_central 更新 B 組 central 服務\r\n \
/update_api 更新 B 組 API 服務 \r\n \
/update_lobby 更新 B 組總大廳服務 \r\n \
/update_games 更新 B 組環境遊戲\r\n \
/update_gamelobby 更新 B 組環境遊戲大廳\r\n \
/start_service 開啟 B 組環境服務(central 與 api)\r\n \
/start_api 開啟 B 組環境 api\r\n \
/start_games 開啟 B 組環境遊戲 \r\n \
\r\n \
前端類： \r\n \
\r\n \
/update_H5 更新 B 組 H5\r\n \
""")

conversations = {}
user_list=[813565234,733834228,690551660,1784519549]
jenkins_robot_config = ('roboco','[jenkins token]')
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

#更新遊戲
def callUpdateGameAction(enviorment):

    switcher = {
                 "UAT": b_update_game.uat,
                 "DEMO": b_update_game.demo,
                 "PRD": b_update_game.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

#更新遊戲大廳
def callUpdateGameLobbyAction(enviorment):

    switcher = {
                 "UAT": b_update_gamelobby.uat,
                 "DEMO": b_update_gamelobby.demo,
                 "PRD": b_update_gamelobby.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func
#更新 api
def callUpdateApiAction(enviorment):

    switcher = {
                 "UAT": b_update_api.uat,
                 "DEMO": b_update_api.demo,
                 "PRD": b_update_api.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

#更新 central
def callUpdateCentralAction(enviorment):

    switcher = {
                 "UAT": b_update_central.uat,
                 "DEMO": b_update_central.demo,
                 "PRD": b_update_central.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func
#更新大廳
def callUpdateLobbyAction(enviorment):

    switcher = {
                 "UAT": b_update_lobby.uat,
                 "DEMO": b_update_lobby.demo,
                 "PRD": b_update_lobby.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateAgentBSAction(enviorment):

    switcher = {
                 "UAT": b_update_agentbs.uat,
                 "PRD": b_update_agentbs.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateDevelopBSAction(enviorment):

    switcher = {
                 "UAT": b_update_developbs.uat,
                 "PRD": b_update_developbs.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateMiddlewareapiAction(enviorment):

    switcher = {
                 "UAT": b_update_middlewareapi.uat,
                 "PRD": b_update_middlewareapi.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateAuthencationapiAction(enviorment):

    switcher = {
                 "UAT": b_update_authencationapi.uat,
                 "PRD": b_update_authencationapi.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateGameresultapiAction(enviorment):

    switcher = {
                 "UAT": b_update_gameresultapi.uat,
                 "PRD": b_update_gameresultapi.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callUpdateThirdpartyapiAction(enviorment):

    switcher = {
                 "UAT": b_update_thirdpartyapi.uat,
                 "PRD": b_update_thirdpartyapi.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStopallGameserverAction(enviorment):
    switcher = {
                 "UAT": b_stop_allgameserver.uat,
                 "DEMO": b_stop_allgameserver.demo,
                 "PRD": b_stop_allgameserver.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStopGameAction(enviorment):
    switcher = {
                 "UAT": b_stop_game.uat,
                 "DEMO": b_stop_game.demo,
                 "PRD": b_stop_game.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStopApiAction(enviorment):
    switcher = {
                 "UAT": b_stop_api.uat,
                 "DEMO": b_stop_api.demo,
                 "PRD": b_stop_api.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStartServiceAction(enviorment):
    switcher = {
                 "UAT": b_start_service.uat,
                 "DEMO": b_start_service.demo,
                 "PRD": b_start_service.prd
               }
    func = switcher.get(enviorment, "nothing")
    return func

def callStartApiAction(enviorment):
    switcher = {
                 "UAT": b_start_api.uat,
                 "DEMO": b_start_api.demo,
                 "PRD": b_start_api.prd
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
    if ("UpdateH5" in call.data) or ("UpdateAgentBS" in call.data) or ("UpdateDevelopBS" in call.data) or ("UpdateMiddlewareapi" in call.data) or ("UpdateAuthencationapi" in call.data) or ("UpdateThirdpartyapi" in call.data) or ("UpdateGameresultapi" in call.data) or ("UpdateApi" in call.data) or ("UpdateYGGameLobby" in call.data) or ("UpdateCentral" in call.data) or ("UpdateGame" in call.data) or ("UpdateLobby" in call.data):
        enviorment=str(call.data.split(":")[0])
        conversations[fromuser_id]['enviorment']=enviorment
        msg = bot.send_message(conversations[fromuser_id]['chat_id'], "請輸入版號")
        bot.register_next_step_handler(msg, verification_step)
        return
    # 需要選擇全部與部分的按鈕
    if ("StartGame" in call.data) or ("StopGame" in call.data):
        enviorment=str(call.data.split(":")[0])
        conversations[fromuser_id]['enviorment']=enviorment
        bot.send_message(conversations[fromuser_id]['chat_id'], "請選擇需要重開全部遊戲或部分遊戲(部分遊戲請先修改 games.txt 並推上 git)：",reply_markup=buttons.genAllorPartialMark(fromuser_id))
        return
    
    if ("all" in call.data) or ("partial" in call.data):
        mode=str(call.data.split(":")[0])
        conversations[fromuser_id]['mode']=mode

    # 不需額外資訊
    if  ("UpdateSvn" in call.data) or ("StopallGameserver" in call.data) or ("StopApi" in call.data) or ("StartService" in call.data) or ("StartApi" in call.data):
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
        elif "/update_games" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateGameAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_gamelobby" in action:
            print("in update_gamelobby")
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateGameLobbyAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_api" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateApiAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_central" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateCentralAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)            
        elif "/update_lobby" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateLobbyAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_agentbs" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateAgentBSAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_developbs" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateDevelopBSAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)  
        elif "/update_middlewareapi" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateMiddlewareapiAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_authencationapi" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateAuthencationapiAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_gameresultapi" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateGameresultapiAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/update_thirdpartyapi" in action:
            version = conversations[fromuser_id]['version']
            enviorment = conversations[fromuser_id]['enviorment']
            func = callUpdateThirdpartyapiAction(enviorment)
            func(bot,jenkins_robot,version,chat_id)
        elif "/stop_all_gameserver" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            func = callStopallGameserverAction(enviorment)
            func(bot,jenkins_robot,chat_id)
        elif "/stop_game" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            mode = conversations[fromuser_id]['mode']
            func = callStopGameAction(enviorment)
            func(bot,jenkins_robot,mode,chat_id)
        elif "/stop_api" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            func = callStopApiAction(enviorment)
            func(bot,jenkins_robot,chat_id)
        elif "/start_service" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            func = callStartServiceAction(enviorment)
            func(bot,jenkins_robot,chat_id)
        elif "/start_api" in action:
            enviorment = conversations[fromuser_id]['enviorment']
            func = callStartApiAction(enviorment)
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
    
@bot.message_handler(commands=['update_games'])
def update_game_handler(message):

    conversations.clear()
    
    fromuser_id = str(message.from_user.id)
    conversations[fromuser_id] = {
        'timestamp': datetime.datetime.now(),
        'chat_id': message.chat.id,
        'action': message.text,
        'enviorment': '',
        'version': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateGameMark(fromuser_id))

@bot.message_handler(commands=['update_gamelobby'])
def update_gamelobby_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateGameLobbyMark(fromuser_id))

@bot.message_handler(commands=['update_api'])
def update_api_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateApiMark(fromuser_id))

@bot.message_handler(commands=['update_lobby'])
def update_lobby_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateLobbyMark(fromuser_id))

@bot.message_handler(commands=['update_central'])
def update_central_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateCentralMark(fromuser_id))

@bot.message_handler(commands=['update_agentbs'])
def upload_agentbs_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateAgentBSMark(fromuser_id))

@bot.message_handler(commands=['update_developbs'])
def update_developbs_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateDevelopBSMark(fromuser_id))

@bot.message_handler(commands=['update_middlewareapi'])
def update_middlewareapi_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateMiddlewareapiMark(fromuser_id))

@bot.message_handler(commands=['update_authencationapi'])
def update_authencationapi_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateAuthencationapiMark(fromuser_id))

@bot.message_handler(commands=['update_gameresultapi'])
def update_gameresultapi_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateGameresultapiMark(fromuser_id))

@bot.message_handler(commands=['update_thirdpartyapi'])
def update_thirdpartyapi_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genUpdateThirdpartyapiMark(fromuser_id))

@bot.message_handler(commands=['stop_all_gameserver'])
def stop_all_gameserver_handler(message):

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
        'enviorment': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStopallGameserverMark(fromuser_id))

@bot.message_handler(commands=['stop_game'])
def stop_game_handler(message):

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

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStopGameMark(fromuser_id))

@bot.message_handler(commands=['stop_api'])
def stop_api_handler(message):

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
        'enviorment': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStopApiMark(fromuser_id))

@bot.message_handler(commands=['start_service'])
def start_api_handler(message):

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
        'enviorment': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStartServiceMark(fromuser_id))

@bot.message_handler(commands=['start_api'])
def start_api_handler(message):

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
        'enviorment': ''
        }

    chat_id = conversations[fromuser_id]['chat_id']

    msg=bot.send_message(chat_id, "請先選擇環境:", reply_markup=buttons.genStartApiMark(fromuser_id))

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
