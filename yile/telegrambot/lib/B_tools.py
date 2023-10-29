def checkUser(message,user_list):
    if message.from_user.id in user_list:
        return 1
    return 0
