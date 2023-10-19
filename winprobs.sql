CREATE OR REPLACE FUNCTION win_probs(home_elo numeric, away_elo numeric, home_court_advantage INTEGER)
RETURNS table(home_prob numeric,away_prob numeric) AS $$
DECLARE
  h NUMERIC := power(10, home_elo/400);
  r NUMERIC := power(10, away_elo/400);
  a NUMERIC := power(10, home_court_advantage/400);
  denom NUMERIC := r + a*h;
  home_prob NUMERIC := a*h / denom;
  away_prob NUMERIC := r / denom;
BEGIN
  RETURN Query select home_prob,away_prob;
END $$ LANGUAGE plpgsql;

