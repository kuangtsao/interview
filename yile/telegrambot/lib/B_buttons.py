from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton

# 產生 yes,no  按鈕
def genMarkup(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 2
    
    ans1="yes:" + str(fromuser_id)
    ans2="no:" + str(fromuser_id)
    itembtn1 = InlineKeyboardButton("yes", callback_data=ans1)
    itembtn2 = InlineKeyboardButton("no", callback_data=ans2)
    markup.add(itembtn1, itembtn2)
    return markup

def genAllorPartialMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    
    ans1="all:" + str(fromuser_id)
    ans2="partial:" + str(fromuser_id)
    itembtn1 = InlineKeyboardButton("全部遊戲", callback_data=ans1)
    itembtn2 = InlineKeyboardButton("部份遊戲", callback_data=ans2)
    markup.add(itembtn1, itembtn2)
    return markup


#產生更新 H5 ，選擇環境的按鈕
def genUpdateH5Mark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateH5"
    platform2 = "DEMO:"+fromuser_id+":UpdateH5"
    platform3 = "PRD:"+fromuser_id+":UpdateH5"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生上傳 YG server/games binary，選擇環境的按鈕
def genUpdateSvnMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateSvn"
    platform2 = "DEMO:"+fromuser_id+":UpdateSvn"
    platform3 = "PRD:"+fromuser_id+":UpdateSvn"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生更新 YG games，選擇環境的按鈕
def genUpdateGameMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateGame"
    platform2 = "DEMO:"+fromuser_id+":UpdateGame"
    platform3 = "PRD:"+fromuser_id+":UpdateGame"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生更新 YG game lobby，選擇環境的按鈕
def genUpdateGameLobbyMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateYGGameLobby"
    platform2 = "DEMO:"+fromuser_id+":UpdateYGGameLobby"
    platform3 = "PRD:"+fromuser_id+":UpdateYGGameLobby"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生更新 YG api，選擇環境的按鈕
def genUpdateApiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateApi"
    platform2 = "DEMO:"+fromuser_id+":UpdateApi"
    platform3 = "PRD:"+fromuser_id+":UpdateApi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生更新 YG central，選擇環境的按鈕
def genUpdateCentralMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateCentral"
    platform2 = "DEMO:"+fromuser_id+":UpdateCentral"
    platform3 = "PRD:"+fromuser_id+":UpdateCentral"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

#產生更新 YG lobby ，選擇環境的按鈕
def genUpdateLobbyMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateLobby"
    platform2 = "DEMO:"+fromuser_id+":UpdateLobby"
    platform3 = "PRD:"+fromuser_id+":UpdateLobby"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup


#產生更新 YG agentbs，選擇環境的按鈕
def genUpdateAgentBSMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateAgentBS"
    platform2 = "PRD:"+fromuser_id+":UpdateAgentBS"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genUpdateDevelopBSMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateDevelopBS"
    platform2 = "PRD:"+fromuser_id+":UpdateDevelopBS"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genUpdateMiddlewareapiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateMiddlewareapi"
    platform2 = "PRD:"+fromuser_id+":UpdateMiddlewareapi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genUpdateAuthencationapiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateAuthencationapi"
    platform2 = "PRD:"+fromuser_id+":UpdateAuthencationapi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genUpdateGameresultapiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateGameresultapi"
    platform2 = "PRD:"+fromuser_id+":UpdateGameresultapi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genUpdateThirdpartyapiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":UpdateThirdpartyapi"
    platform2 = "PRD:"+fromuser_id+":UpdateThirdpartyapi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("PRD", callback_data=platform2)
    markup.add(itembtn1, itembtn2)

    return markup

def genStopallGameserverMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StopallGameserver"
    platform2 = "DEMO:"+fromuser_id+":StopallGameserver"
    platform3 = "PRD:"+fromuser_id+":StopallGameserver"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

def genStopGameMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StopGame"
    platform2 = "DEMO:"+fromuser_id+":StopGame"
    platform3 = "PRD:"+fromuser_id+":StopGame"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup
 
def genStopApiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StopApi"
    platform2 = "DEMO:"+fromuser_id+":StopApi"
    platform3 = "PRD:"+fromuser_id+":StopApi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup
 
def genStartServiceMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StartService"
    platform2 = "DEMO:"+fromuser_id+":StartService"
    platform3 = "PRD:"+fromuser_id+":StartService"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

def genStartApiMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StartApi"
    platform2 = "DEMO:"+fromuser_id+":StartApi"
    platform3 = "PRD:"+fromuser_id+":StartApi"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup

def genStartGameMark(fromuser_id):
    markup = InlineKeyboardMarkup()
    markup.row_width = 1
    platform1 = "UAT:"+fromuser_id+":StartGame"
    platform2 = "DEMO:"+fromuser_id+":StartGame"
    platform3 = "PRD:"+fromuser_id+":StartGame"
    itembtn1 = InlineKeyboardButton("UAT", callback_data=platform1)
    itembtn2 = InlineKeyboardButton("DEMO", callback_data=platform2)
    itembtn3 = InlineKeyboardButton("PRD", callback_data=platform3)
    markup.add(itembtn1, itembtn2, itembtn3)

    return markup        
