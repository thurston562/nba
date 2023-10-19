WITH win_loss AS (select game_date, 
                         visitor_team,
                         visitor_score,
                         case when (visitor_score > home_score) then 'w' else 'l' end v_outcome,
                         home_team,
                         home_score,
                         case when (home_score > visitor_score) then 'w' else 'l' end h_outcome 
                  from game_summary)

select game_date, team, score,outcome,location,(game_date - lag(game_date,1) over (partition by team order by game_date) )  "last game",opp,opp_score
from
(
select game_date,visitor_team as team,visitor_score as score ,v_outcome as outcome,'away' as location,home_team as opp,home_score as opp_score 
from win_loss
union
select game_date,home_team as team,home_score,h_outcome,'home',visitor_team, visitor_score  
from win_loss
order by team, game_date
) as wins_by_team

