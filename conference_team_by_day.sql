drop table if exists con_team_by_day;
create table con_team_by_day as
select e.team,
       trim(to_char(game_date,'day')) as day,
       case when last_game > 5 then 6 else last_game end last_game,
       home,
       conference,
       sum(case when team_score > opp_score then 1.0  end) / 
       sum(1.0) win_perc

from elo_sum e join nba_conference c on (e.opp = c.team)

group by 1,2,3,4,5
;


