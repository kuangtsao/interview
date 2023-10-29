import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT gameresultapi")
    update_gameresultapi = 'https://jenkins.fromer.url/job/B_GAMERESULT_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_gameresultapi, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD gameresultapi")
    update_gameresultapi = 'https://jenkins.fromer.url/job/B_GAMERESULT_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_gameresultapi, data=parameters, auth=jenkins_robot['config'])
