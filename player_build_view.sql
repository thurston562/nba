select date_game,
       player_name,
       lag(fg_pct) over (partition by player_name order by date_game) as fg_pct_last_10,
       lag(pts) over (partition by player_name order by date_game) as pts_last_10,
       lag(fg3_pct) over (partition by player_name order by date_game) as fg3_pct_last_10,
       lag(tov) over (partition by player_name order by date_game) tov_last_10,
       lag(blk) over (partition by player_name order by date_game) blk_last_10,
       lag(stl) over (partition by player_name order by date_game) stl_last_10,
       lag(trb) over (partition by player_name order by date_game) trb_last_10,
       lag(plusminus) over (partition by player_name order by date_game) plusminus_last_10,
       lag(gamescore) over (partition by player_name order by date_game) gamescore_last_10
from(
select date_game,player_name,
       avg(fg_pct) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) as fg_pct,
       avg(pts) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) as pts,
       avg(game_three_perc) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) as fg3_pct,
       avg(tov) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) tov,
       avg(blk) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) blk,
       avg(stl) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) stl,
       avg(trb) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) trb,
       avg(plus_minus) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) plusminus,
       avg(game_score) over (partition by player_name order by date_game ROWS BETWEEN 9 PRECEDING AND CURRENT ROW) gamescore
from game_details 
where date_game > '2020-12-20'::date) as a
