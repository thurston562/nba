create or replace view game_sum_view_elo_same as
select get_season(game_date) as season,
       rank() over (partition by get_season(game_date) order by game_date,start_time_et,home_team) as game_number,
       home_team,
       case when home_score > visitor_score then 1 else 0 end home_score ,
       visitor_team,
       case when visitor_score > home_score then 1 else 0 end visitor_score  
from game_summary where game_date > '2020-11-01' and (select conference from nba_conference where home_team = team) = (select conference from nba_conference where visitor_team = team)
