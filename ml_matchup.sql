select player_name, date_game, team_name, opp_name, home, dow, team_conference, opp_conference, 
avg(game_score) over (partition by player_name order by date_game rows between unbounded preceding and 1 preceding) as avg_game_score,
avg(game_score) over (partition by player_name order by date_game rows between 10 preceding and 1 preceding) as last_10_avg_game_score,

