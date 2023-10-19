drop table if exists team_game_summary ;
create table team_game_summary as
select get_season(game_date),rank() over (partition by get_season(game_date),team order by game_date) as game_number,game_date, start_time_et, team, team_score,opp,opp_score,home,case when (team_score > opp_score) then 'W' else 'L' end as outcome,team_score - opp_score as pt_diff,game_date - lag(game_date) over (partition by team order by game_date) as last_game
from
(
select game_date,start_time_et,visitor_team as team,visitor_score as team_score ,home_team as opp, home_score as opp_score, 'N' as home
from game_summary
union
select game_date,start_time_et,home_team as team,home_score as team_score ,visitor_team as opp,visitor_score as opp_score, 'Y' as home
from game_summary) as a
order by team, game_date;

drop table if exists elo_sum;
create table elo_sum as select gs.*,"Elo",game_score,extract (isodow from game_date) as dow from team_game_summary gs inner join elo_score_table on ("Team" = team and "Date" = game_date) 
;
--drop table if exists elo_score_table;

drop table if exists avg_stats;
create  table avg_stats as
select  team,last_game,avg(case when home = 'Y' then  team_score end ) as team_home_avg , avg(case when home = 'N' then  team_score end ) as team_away_avg,avg(case when home = 'Y' then  opp_score end ) as home_opp_avg,avg(case when home = 'N' then  opp_score end ) as away_opp_avg,avg(case when home = 'Y' then game_score end) as home_game_score_avg,avg(case when home = 'N' then game_score end) as away_game_score_avg  from elo_sum where get_season = '2021-22' and last_game < 6 group by 1,2 order by 1,2;


