--with opponent as       (select o.team_id as opp_team,
--               o.date_game,
--               sum(o.fg)  as opp_fg,
--               sum(o.fga) as opp_fga, 
--               sum(o.game_three_made)  as opp_gtm ,
--               sum(o.game_three_att)  as opp_gta, 
--               sum(o.tov)  as opp_turnovers,
--               sum(o.orb)  as opp_orb,
--               sum(o.drb)  as opp_drb ,
--               sum(o.trb)  as opp_trb,
--               sum(o.ft)  as opp_ft,
--               sum(o.fta) as opp_ft_att,
--               sum(o.pf)  as opp_pf 
--               from game_details t join game_details o on (o.team_id = t.opp_id and t.date_game = o.date_game and o.opp_id = t.team_id) 
--               where t.date_game > '1999-09-20'::date
--               group by 1,2) 	

drop table if exists team_game_stats_agg;  
create table team_game_stats_agg as
with team_game_stats  as
(select get_season(t.date_game) as season, 
       t.date_game,
       t.team_id,
       t.opp_id,
       t.game_result,
      -- avg(split_part(game_age,'-',1)::float + split_part(game_age,'-',2)::float / 365) as team_age,
       avg(date_part('day',t.date_game::timestamp -dob::date)) as team_age,
       sum(t.fg)  as team_fg,
       sum(t.fga) as team_fga, 
       sum(t.game_three_made)  as team_gtm ,
       sum(t.game_three_att)  as team_gta, 
       sum(t.tov)  as team_turnovers,
       sum(t.orb)  as team_orb,
       sum(t.drb)  as team_drb ,
       sum(t.trb)  as team_trb,
       sum(t.ft)  as team_ft,
       sum(t.fta) as team_ft_att,
       sum(t.pf)  as team_pf 
      from game_details t  join player_summary s on (s.name = t.player_name)
group by 1,2,3,4,5 )

select t.*,
       o.team_age as opp_age,
       o.team_fg as opp_fg,
       o.team_fga as opp_fga,
--       o.team_fga as opp_fga, 
       o.team_gtm as opp_gtm, 
       o.team_gta as opp_gta, 
       o.team_turnovers as opp_turnover, 
       o.team_orb as opp_orb, 
       o.team_drb as opp_drb, 
       o.team_trb as opp_trb,
       o.team_ft as opp_ft, 
       o.team_ft_att as opp_ft_att, 
       o.team_pf as opp_pf 
from team_game_stats t join team_game_stats o on (o.date_game = t.date_game and o.team_id = t.opp_id and o.opp_id = t.team_id) 
where t.date_game > '1999-09-01';

drop table if exists full_name_team_game_stats;

create table full_name_team_game_stats as
select *,(select fullname from latest_team_name where team_id = t_abbr) as team_name,(select fullname from latest_team_name where opp_id = t_abbr) as opp_name from team_game_stats_agg 
;
drop table team_game_stats_agg;
drop table if exists elo_game_stats;
create table elo_game_stats as 
select f.*,
      e.home as home,
      e.dow as dow,
      e."Elo" as team_elo,
      e.last_game as team_last_game,
      e.team_score as team_score,
      e.game_score as team_game_score,
      e.opp_score as opp_score
      
from 
      elo_sum e join full_name_team_game_stats f on (e.get_season = f.season and e.game_date = f.date_game and e.team = f.team_name and e.opp = f.opp_name) ;

drop table if exists elo_game_stats_full;
create table elo_game_stats_full as
select f.*,
      e."Elo" as opp_elo,
      e.last_game as opp_last_game,
      e.game_score as opp_game_score,
      (select conference from nba_conference where team = team_name) as team_conference,
      (select conference from nba_conference where team = opp_name) as opp_conference

from
      elo_sum e join elo_game_stats f on (e.get_season = f.season and e.game_date = f.date_game and e.team = f.opp_name and e.opp = f.team_name);

drop table elo_game_stats;
drop table full_name_team_game_stats;

drop table if exists elo_player_sum;
create table elo_player_sum as
select
p.player_name,
p.gs        , 
 p.mp       ,  
 p.fg       ,   
 p.fga      ,    
 p.fg_pct   ,     
 p.game_three_made,
 p.game_three_att, 
 p.game_three_perc, 
 p.ft ,      
 p.fta ,      
 p.ft_pct,     
 p.orb    ,     
 p.drb ,
 p.trb  ,
 p.ast   ,
 p.stl    ,
 p.blk   ,
 p.tov    ,
 p.pf      ,
 p.pts      ,
 game_score, 
 plus_minus,
 g.*
from game_details p left outer join elo_game_stats_full g on (p.date_game = g.date_game and g.team_id = p.team_id)
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66;

drop table if exists gs_player;
create table gs_player as select *,date_game - lag(date_game) OVER (PARTITION BY player_name ORDER BY date_game) AS days_since_last_game from game_details ;


