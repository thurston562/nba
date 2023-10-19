drop view team_view_scores;
create or replace view team_view_scores as
with cte_gs as 
(select date_game as cte_game_date,team_id as team_id,sum(coalesce(game_score,0)) game_score,date_game - lag(date_game) over (partition by team_id order by date_game) last_game 
 from game_details 
 where date_game > '2000-09-19'  
 group by 1,2 ),
cte_gc as
(
select game_date,team_name,days_since_last_game from
(
select game_date,team_name,game_date - lag(game_date) over (partition by team_name order by game_date) as days_since_last_game
from
(
select b.game_date ,
case when (home = 't') then team else opponent end as team_name
from game_matchup b
union
select c.game_date,
case when (home = 'f') then team else opponent end as team_name
from game_matchup c
) a
) b
where b.game_date = current_date
order by 1

)
select row_number() over (order by z."Date") as "Game_ID",z."Date",z."Season",z."A_Team",z."A_Points",z."A_game_score",z."A_last_team_game",z."H_Team",z."H_Points",z."H_game_score",z."H_last_team_game"
from
(select a.game_date as "Date",get_season(a.game_date) as "Season",a.visitor_team as "A_Team",a.visitor_score as "A_Points",
      (select game_score from cte_gs join team_name on (trim(fullname) = trim(visitor_team)) where team_id = t_abbr and cte_game_date = a.game_date) as "A_game_score",
      (select last_game from cte_gs join team_name on (trim(fullname) = trim(visitor_team)) where team_id = t_abbr and cte_game_date = a.game_date) as "A_last_team_game" ,
       a.home_team as "H_Team",a.home_score as "H_Points",
      (select game_score from cte_gs join team_name on (trim(fullname) = trim(home_team)) where team_id = t_abbr and cte_game_date = a.game_date) as "H_game_score",
      (select last_game from cte_gs join team_name on (trim(fullname) = trim(home_team)) where team_id = t_abbr and cte_game_date = a.game_date) as "H_last_team_game"  
from game_summary a 
where game_date > '2000-09-19'::date 
union
(select b.game_date,get_season(b.game_date) as season,
case when (home = 't') then opponent else team end as visitor_team,
null::int as visitor_score,
null::float as visitor_game_score,
(select days_since_last_game from cte_gc where (select case when (b.home = 't') then opponent else team end) = team_name ) as last_visitor_team_game,
case when (home = 'f') then opponent else team end as home_team, 
null::int as home_score, 
null::float as home_game_score,
(select days_since_last_game from cte_gc where (select case when (b.home = 't') then team else opponent end) = team_name )  as last_home_team_game
from game_matchup b
where game_date = current_date
order by  game_date)
order by "Date"
) z
