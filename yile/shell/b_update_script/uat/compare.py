games_list = open('/data/YG/games.txt').read().split('\n')
all_games_list = open('/data/YG/all_games.txt').read().split('\n')

compare = set(games_list) - set(all_games_list)
check=list(compare)
if check == []:
    print(True)
else:
    print(games_list)
