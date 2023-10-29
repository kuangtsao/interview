import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始上傳 B 組 UAT DevelopBS")
    update_developbs = 'https://jenkins.fromer.url/job/B_DEVELOPBS_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_developbs, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始上傳 B 組 PRD DevelopBS")
    update_developbs = 'https://jenkins.fromer.url/job/B_DEVELOPBS_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_developbs, data=parameters, auth=jenkins_robot['config'])
