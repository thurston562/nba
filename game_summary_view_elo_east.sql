create or replace view game_sum_view_elo_east as
select get_season(game_date) as season,
       rank() over (partition by get_season(game_date) order by game_date,start_time_et,home_team) as game_number,
       home_team,
       case when home_score > visitor_score then 1 else 0 end home_score ,
       visitor_team,
       case when visitor_score > home_score then 1 else 0 end visitor_score 

from game_summary where game_date > '2020-11-01' and visitor_team in (select team from nba_conference where conference = 'W') 
                                                 and home_team in (select team from nba_conference where conference = 'E')

