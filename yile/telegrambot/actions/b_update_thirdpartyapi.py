import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT thirdpartyapi")
    update_thirdpartyapi = 'https://jenkins.fromer.url/job/B_THIRDPARTYAPI_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_thirdpartyapi, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD thirdpartyapi")
    update_thirdpartyapi = 'https://jenkins.fromer.url/job/B_THIRDPARTYAPI_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_thirdpartyapi, data=parameters, auth=jenkins_robot['config'])
