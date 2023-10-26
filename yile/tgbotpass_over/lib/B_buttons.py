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
