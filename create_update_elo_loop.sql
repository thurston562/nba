CREATE OR REPLACE FUNCTION update_basketball_elo_ratings()
RETURNS VOID AS $$
DECLARE
  k INTEGER := 24;
  game RECORD;
  var_away_team text;
  var_home_team text;
  var_away_away_elo_score numeric;
  var_away_full_elo_score numeric;
  var_away_home_elo_score numeric;
  var_home_home_elo_score numeric;
  var_home_away_elo_score numeric;
  var_home_full_elo_score numeric;
  var_home_team_score integer;
  var_away_team_score integer;
  updated_home_full_elo_score numeric;
  updated_home_home_elo_score numeric;
  updated_away_away_elo_score numeric;
  updated_away_full_elo_score numeric;
BEGIN
  FOR game IN SELECT * FROM game_summary where game_date = current_date - 1 LOOP
    var_away_team = game.visitor_team;
    var_home_team = game.home_team;
    var_away_team_score = game.visitor_score;
    var_home_team_score = game.home_score;
 
    var_away_away_elo_score = (select get_prev_elo(var_away_team,game.game_date,get_season(game.game_date),'A'));
    var_away_home_elo_score = (select get_prev_elo(var_away_team,game.game_date,get_season(game.game_date),'H'));
    var_away_full_elo_score = (select get_prev_elo(var_away_team,game.game_date,get_season(game.game_date),'F')); 
    var_home_full_elo_score = (select get_prev_elo(var_home_team,game.game_date,get_season(game.game_date),'F')); 
    var_home_home_elo_score = (SELECT get_prev_elo(var_home_team,game.game_date,get_season(game.game_date),'H'));
    var_home_away_elo_score = (SELECT get_prev_elo(var_home_team,game.game_date,get_season(game.game_date),'A'));
    updated_home_full_elo_score = (SELECT (update_elo).updated_home_elo FROM (SELECT update_elo(var_home_team_score,var_away_team_score,var_home_full_elo_score,var_away_full_elo_score,69)) a);
    updated_home_home_elo_score = (SELECT (update_elo).updated_home_elo FROM (SELECT update_elo(var_home_team_score,var_away_team_score,var_home_home_elo_score,var_away_full_elo_score,69)) a);
    updated_away_away_elo_score = (SELECT (update_elo).updated_away_elo FROM (SELECT update_elo(var_home_team_score,var_away_team_score,var_away_away_elo_score,var_home_full_elo_score,69)) a);
    updated_away_full_elo_score = (SELECT (update_elo).updated_away_elo FROM (SELECT update_elo(var_home_team_score,var_away_team_score,var_away_full_elo_score,var_home_full_elo_score,69)) a);  
        

   INSERT INTO latest_elo (team, season,game_date, away_elo_score, home_elo_score, full_elo_score)
    VALUES (var_away_team, get_season(game.game_date),game.game_date,updated_away_away_elo_score,var_away_home_elo_score,updated_away_full_elo_score);
   
   INSERT INTO latest_elo (team, season,game_date, away_elo_score, home_elo_score, full_elo_score)
    VALUES (var_home_team, get_season(game.game_date),game.game_date,var_home_away_elo_score,updated_home_home_elo_score,updated_home_full_elo_score);
  END LOOP;
END $$ LANGUAGE plpgsql;

