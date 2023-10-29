import telebot
import requests

def uat(bot,jenkins_robot,mode,chat_id):
    bot.send_message(chat_id,"停止 B 組 UAT 遊戲")
    stop_game = 'https://jenkins.fromer.url/job/B_GAMES_STOP/buildWithParameters'
    parameters = { 'enviorment': 'UAT','option': mode, 'bot': jenkins_robot['bot_to']}
    requests.post(stop_game, data=parameters, auth=jenkins_robot['config'])


def demo(bot,jenkins_robot,mode,chat_id):
    bot.send_message(chat_id,"停止 B 組 DEMO 遊戲")
    stop_game = 'https://jenkins.fromer.url/job/B_GAMES_STOP/buildWithParameters'
    parameters = { 'enviorment': 'DEMO','option': mode, 'bot': jenkins_robot['bot_to']}
    requests.post(stop_game, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,mode,chat_id):
    bot.send_message(chat_id,"停止 B 組 PRD 遊戲")
    stop_game = 'https://jenkins.fromer.url/job/B_GAMES_STOP/buildWithParameters'
    parameters = { 'enviorment': 'PRD','option': mode, 'bot': jenkins_robot['bot_to']}
    requests.post(stop_game, data=parameters, auth=jenkins_robot['config'])
