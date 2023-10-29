import telebot
import requests

def uat(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 UAT API")
    start_api = 'https://jenkins.fromer.url/job/B_API_START/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'bot': jenkins_robot['bot_to']}
    requests.post(start_api, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 DEMO API")
    start_api = 'https://jenkins.fromer.url/job/B_API_START/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'bot': jenkins_robot['bot_to']}
    requests.post(start_api, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 PRD API")
    start_api = 'https://jenkins.fromer.url/job/B_API_START/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'bot': jenkins_robot['bot_to']}
    requests.post(start_api, data=parameters, auth=jenkins_robot['config'])
