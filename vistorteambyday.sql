drop table if exists visitor_team_by_day;
create table visitor_team_by_day as
select team,
       sum(case when trim(to_char(game_date,'day')) = 'monday' then 
       case when team_score > opp_score then 1.0  end end) 
       / sum(case when trim(to_char(game_date,'day')) = 'monday' then 1.0 end) as Monday,
       sum(case when trim(to_char(game_date,'day')) = 'tuesday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'tuesday' then 1.0 end) as Tuesday,
      sum(case when trim(to_char(game_date,'day')) = 'wednesday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'wednesday' then 1.0 end) as Wednesday,
      sum(case when trim(to_char(game_date,'day')) = 'thursday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'thursday' then 1.0 end) as Thursday,
      sum(case when trim(to_char(game_date,'day')) = 'friday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'friday' then 1.0 end) as Friday,
      sum(case when trim(to_char(game_date,'day')) = 'saturday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'saturday' then 1.0 end) as Saturday,
      sum(case when trim(to_char(game_date,'day')) = 'sunday' then
       case when team_score > opp_score then 1.0  end end)
       / sum(case when trim(to_char(game_date,'day')) = 'sunday' then 1.0 end) as Sunday
from elo_sum
where home = 'N'
group by 1
