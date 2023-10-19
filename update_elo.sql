CREATE OR REPLACE FUNCTION update_elo(home_score INTEGER, away_score INTEGER, home_elo numeric, away_elo numeric, home_court_advantage INTEGER)
RETURNS TABLE (updated_home_elo NUMERIC, updated_away_elo NUMERIC) AS $$
DECLARE
  var_home_prob NUMERIC;
  var_away_prob NUMERIC;
  home_win INTEGER;
  away_win INTEGER;
  k NUMERIC;
BEGIN
  var_home_prob = (select (win_probs).home_prob from (select win_probs(home_elo,away_elo,home_court_advantage)) as a);
  var_away_prob = (select (win_probs).away_prob from (select win_probs(home_elo,away_elo,home_court_advantage)) as c);
  raise notice '%',var_home_prob;
  IF home_score - away_score > 0 THEN
    home_win := 1;
    away_win := 0;
  ELSE
    home_win := 0;
    away_win := 1;
  END IF;

  k := elo_k(home_score - away_score, home_elo - away_elo);
  raise notice 'k is %',k;
  updated_home_elo := home_elo + k * (home_win - var_home_prob);
  updated_away_elo := away_elo + k * (away_win - var_away_prob);
  raise notice 'update_home elo is %',updated_home_elo;
  RETURN Query select updated_home_elo,updated_away_elo;
END $$ LANGUAGE plpgsql;

