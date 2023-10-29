import telebot
import requests

def uat(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"停止 B 組 UAT API")
    stop_api = 'https://jenkins.fromer.url/job/B_API_STOP/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'bot': jenkins_robot['bot_to']}
    requests.post(stop_api, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"停止 B 組 DEMO API")
    stop_api = 'https://jenkins.fromer.url/job/B_API_STOP/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'bot': jenkins_robot['bot_to']}
    requests.post(stop_api, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"停止 B 組 PRD API")
    stop_api = 'https://jenkins.fromer.url/job/B_API_STOP/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'bot': jenkins_robot['bot_to']}
    requests.post(stop_api, data=parameters, auth=jenkins_robot['config'])
