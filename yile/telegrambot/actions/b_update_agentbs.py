import telebot
import requests

def uat(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始更新 B 組 UAT AgentBS")
    update_agentbs = 'https://jenkins.fromer.url/job/B_AGENTBS_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'UAT', 'version': version, 'bot': jenkins_robot['bot_to']}
    requests.post(update_agentbs, data=parameters, auth=jenkins_robot['config'])

def prd(bot,jenkins_robot,version,chat_id):
    bot.send_message(chat_id,"開始上傳 B 組 PRD AgentBS")
    update_agentbs = 'https://jenkins.fromer.url/job/B_AGENTBS_UPDATE/buildWithParameters'
    parameters = { 'enviorment': 'PRD', 'version': version, 'bot': jenkins_robot['bot_to']}
    print("url: ",update_agentbs)
    print("parameters: ",parameters)
    requests.post(update_agentbs, data=parameters, auth=jenkins_robot['config'])
