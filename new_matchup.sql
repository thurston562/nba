with cte_last_game as (select p_name, last_game from (select player_name p_name ,current_date - date_game as last_game, rank() over (partition by player_name order by date_game desc) as rn  from game_details where date_game > '10/1/2020'::date order by 1,date_game desc) a where a.rn = 1) 


select game_date,team,a.player_name,opponent,date_update,case when injury_notes ilike '%out%' then 'o' else 'p' end injury,(select avg(game_score) from game_details where player_name = left(a.player_name,length(player_name)) and date_game >'10-01-2020') as gm_score, (select avg(game_score) from game_details where player_name = left(a.player_name,length(player_name)) and date_game >'10-01-2020' and coalesce(game_location,'A') = case when home = 't' then 'A' else '@' end ) gm_location_avg, (select last_game from cte_last_game where p_name = a.player_name) as last_game  from game_matchup a where game_date = current_date  order by team,gm_score desc

