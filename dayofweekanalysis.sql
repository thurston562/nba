select 
--get_season,
sub.team,
opp,
dayofweek,
sum(case when (outcome = 'W') then 1 end) as win,
sum(case when (outcome = 'L') then 1 end) as lost,
sum(case when (outcome = 'W') then 1 else 0 end)::float / (sum(case when (outcome = 'W') then 1 else 0 end) + sum(case when (outcome = 'L') then 1 else 0 end))::float  as winperc
from 
(select get_season,
        t1.team,
        t1.home,
        opp,
        outcome,
        to_char(t1.game_date,'day') as dayofweek 
 from elo_sum t1 join game_matchup t2 on (t2.team = t1.team and t1.opp = t2.opponent and t2.game_date = current_date) 
 where 
     trim(to_char(t1.game_date,'day')) = trim(to_char(t2.game_date,'day')) 
 and trim(to_char(t2.game_date,'day')) = trim(to_char(current_date,'day'))
 and trim(to_char(t1.game_date,'day')) = trim(to_char(current_date,'day')) 
 and t1.home = 'N'
 and t2.home = 'N' 
) as sub 
group by 1,2,3 
order by team,winperc desc;
