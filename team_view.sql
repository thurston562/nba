drop view team_summary_view;
create or replace view team_summary_view as
select row_number() over (order by "Date") "Game_ID",
"Date",
 "Season",
 "H_Team",
 "H_Points",
 "A_Team",
 "A_Points"
from 
(select game_date as "Date",
get_season(game_date) as "Season",
fix_team(trim(home_team)) as "H_Team",
home_score as "H_Points",
fix_team(trim(visitor_team))  as "A_Team",
visitor_score as "A_Points"
from
game_summary
union
select game_date as "Date",get_season(game_date) as "Season",case when home is True then team else opponent end as "H_Team",null::int as "H_Points",case when home is False then team else opponent end as "Away_Team",null::int as "A_Points"
 from game_matchup where game_date = current_date group by 1,2,3,4,5,6) a;


