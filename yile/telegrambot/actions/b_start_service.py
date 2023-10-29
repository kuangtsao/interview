import telebot
import requests

def uat(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 UAT SERVICE(central 與 api)")
    start_service = 'https://jenkins.fromer.url/job/B_GAMES_SERVICE_START/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'bot': jenkins_robot['bot_to']}
    requests.post(start_service, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 DEMO SERVICE(central 與 api)")
    start_service = 'https://jenkins.fromer.url/job/B_GAMES_SERVICE_START/buildWithParameters'
    parameters = { 'enviorment': 'DEMO', 'bot': jenkins_robot['bot_to']}
    requests.post(start_service, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,chat_id):
    bot.send_message(chat_id,"啟動 B 組 PRD SERVICE(central 與 api)")
    start_service = 'https://jenkins.fromer.url/job/B_GAMES_SERVICE_START/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'bot': jenkins_robot['bot_to']}
    requests.post(start_service, data=parameters, auth=jenkins_robot['config'])
