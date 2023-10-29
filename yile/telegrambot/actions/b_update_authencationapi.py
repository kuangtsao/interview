import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT authencationapi")
    update_authencationapi = 'https://jenkins.fromer.url/job/B_AUTHENCATIONAPI_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_authencationapi, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD authencationapi")
    update_authencationapi = 'https://jenkins.fromer.url/job/B_AUTHENCATIONAPI_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_authencationapi, data=parameters, auth=jenkins_robot['config'])
