games_list = open( '/data/YG/games.txt' ).read().split('\n')
all_games_list = open( '/data/YG/all_games.txt' ).read().split('\n')
repeat_check = set(games_list)
flag = 0
for i in repeat_check:
    if games_list.count(i) > 1:
        flag = 1


if flag == 1:
    print(games_list) 
else:
    print(True)
