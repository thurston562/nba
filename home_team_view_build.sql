create or replace view home_team_stats as
select team_id,
       date_game,
   --   avg(fg_avg) over (partition by team_id order by date_game ROWS Between 9 preceding and current row) as "H_Last_10_Avg_FG_Avg",
      round(lag(avg(fg_att)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_FG_Attempts",
      round(lag(avg(offensive_reb)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Offensive_Rebounds",
      round(lag(avg(defensive_reb)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Defensive_Rebounds",
      round(lag(avg(total_reb)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Total_Rebounds",
      round(lag(avg(game_score::numeric)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Game_Score",
      round(lag(avg(total_turnovers)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Turnovers",
      round(lag(avg(total_assist)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Assist",
      round(lag(avg(total_steals)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Steals",
      round(lag(avg(total_blocks)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Blocks",
      round(lag(avg(total_free_throw_made)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_FTM",
      round(lag(avg(total_free_throw_att)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_FTA",
   --   avg(free_throw_pct) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_FTP",
      round(lag(avg(points)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_Points",
      round(lag(avg(number_of_threes)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_ThreePTA",
   --   avg(average_three_pt_perc) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_ThreePTC",
      round(lag(avg(number_of_threes_made)) over (partition by team_id order by date_game ROWS Between 9 preceding and current row),2) as "H_Last_10_Avg_ThreeMade"
from
(select team_id,
        date_game,
        game_location,
        avg(fg_pct) as fg_avg,
        sum(fga) as fg_att,
        sum(orb) as offensive_reb,
        sum(drb) as defensive_reb,
        sum(trb) as total_reb,
        sum(game_score) as game_score,
        sum(tov) as total_turnovers,
        sum(ast) as total_assist,
        sum(stl) as total_steals,
        sum(blk) as total_blocks,
        sum(ft) as total_free_throw_made,
        sum(fta) as total_free_throw_att,
        avg(ft_pct) as free_throw_pct,
        sum(pts) as points, 
        sum(game_three_att) number_of_threes,
        avg(game_three_perc) as average_three_pt_perc,
        sum(game_three_made) as number_of_threes_made

 
 from game_details  
 where date_game > '2000-09-01' and game_location is null
 group by 1,2,3
) a 
group by 1,2
