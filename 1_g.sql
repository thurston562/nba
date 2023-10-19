select game_date,team,team_score,opponent,opponent_score,days_since_last_game 
from
(
select game_date,team,team_score,opponent,opponent_score,game_date - lag(game_date) over (partition by team order by game_date) as days_since_last_game
from
(
select game_date,home_team as team,home_score as team_score,visitor_team as opponent,visitor_score as opponent_score
from game_summary
union
select game_date,visitor_team as team,visitor_score as team_score,home_team as opponent,home_score as opponent_score
from game_summary
) a
order by team,game_date) b
where days_since_last_game = 1 and game_date > '2020-11-20' and team ilike 'Dall%'
