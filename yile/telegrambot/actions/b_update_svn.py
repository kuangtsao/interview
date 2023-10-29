import telebot
import requests

def uat(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT SVN")
    upload_binary = 'https://jenkins.fromer.url/job/B_SVN_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'bot': jenkins_robot['bot_to']}
    requests.post(upload_binary, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 DEMO SVN")
    upload_binary = 'https://jenkins.fromer.url/job/B_SVN_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'bot': jenkins_robot['bot_to']}
    requests.post(upload_binary, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD SVN")
    upload_binary = 'https://jenkins.fromer.url/job/B_SVN_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'bot': jenkins_robot['bot_to']}
    requests.post(upload_binary, data=parameters, auth=jenkins_robot['config'])
