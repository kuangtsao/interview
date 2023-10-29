import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT CENTRAL")
    update_central = 'https://jenkins.fromer.url/job/B_CENTRAL_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_central, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 DEMO CENTRAL")
    update_central = 'https://jenkins.fromer.url/job/B_CENTRAL_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_central, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 PRD CENTRAL")
    update_central = 'https://jenkins.fromer.url/job/B_CENTRAL_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_central, data=parameters, auth=jenkins_robot['config'])
