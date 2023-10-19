drop table if exists team_by_day;
create table team_by_day as
select team,
       trim(to_char(game_date,'day')) as day,
       'Y' as home,
       sum(case when team_score > opp_score then 1.0  end) / 
       sum(1.0) win_perc

from elo_sum
where home = 'Y'
group by 1,2,3
union
select team,
       trim(to_char(game_date,'day')) as day,
       'N' as home,
       sum(case when team_score > opp_score then 1.0  end) /
       sum(1.0) win_perc

from elo_sum
where home = 'N'
group by 1,2,3

