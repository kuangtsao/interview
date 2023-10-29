import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT API")
    update_api = 'https://jenkins.fromer.url/job/B_API_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version ,'bot': jenkins_robot['bot_to']}
    requests.post(update_api, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 DEMO API")
    update_api = 'https://jenkins.fromer.url/job/B_API_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_api, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD API")
    update_api = 'https://jenkins.fromer.url/job/B_API_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_api, data=parameters, auth=jenkins_robot['config'])
