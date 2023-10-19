with player_scores as (select player_name,avg(game_score) as player_game_score from gs_player where game_season = '2022-23' group by 1), team_score as (select team_id,avg(sum) as avg_team from (select team_id,date_game, sum(game_score) from gs_player where game_season = '2022-23' group by 1,2) as fe  group by 1)

select player_name,team_id,player_game_score,avg_team,(player_game_score / avg_team) * 100 as player_percent from ( 
select a.player_name, a.team_id,player_game_score,avg_team from gs_player a join player_scores b on (a.player_name = b.player_name) join team_score c on (a.team_id = c.team_id) where a.game_season = '2022-23' group by 1,2,3,4 ) as fu order by player_percent desc
