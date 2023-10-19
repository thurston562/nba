select a.date_game from (
select 
player_name ,  game_season , date_game  , game_age , team_id , game_location , opp_id , game_result , gs ,  mp   , fg , fga , fg_pct , game_three_made , game_three_att , game_three_perc , ft , fta , ft_pct , orb , drb , trb , ast , stl , blk , tov , pf , pts , game_score , plus_minus,count(*) as c_1
from 
game_details 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
) a
where a.c_1 > 1
group by 1
