select player_name,
       team,
      (select avg(pts) from game_details where player_name = left(m.player_name,length(player_name)) and date_game > '2020-10-01'::date) as season_avg,
      (select avg(pts) from game_details where player_name = left(m.player_name,length(player_name)) and date_game > '2020-10-01'::date and home = (case when game_location is null then False else True end)) as location_avg,
      (select avg(pts) from game_details, team_name where player_name = left(m.player_name,length(player_name)) and date_game > '2020-10-01'::date and opp_id = t_abbr and fullname = opponent) as avg_opp
      
from 
   game_matchup m  
where 
   game_date = current_date and (injury_notes not ilike '%out%' or injury_notes is null);
