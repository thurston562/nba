select game_date,visitor_team,visitor_score,home_team,home_score from game_details,game_summary where game_date > '2020-11-01'::date and date_game = game_date  and (visitor_team ilike 'Charlo%' or home_team ilike 'Charl%') and game_date not in (select date_game from game_details where player_name ilike '%Ball%'  and date_game > '2020-12-01') group by 1,2,3,4,5

