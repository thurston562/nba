CREATE OR REPLACE FUNCTION home_odds_on(home_elo INTEGER, away_elo INTEGER, home_court_advantage INTEGER)
RETURNS NUMERIC AS $$
DECLARE
  h NUMERIC := power(10, home_elo/400);
  r NUMERIC := power(10, away_elo/400);
  a NUMERIC := power(10, home_court_advantage/400);
BEGIN
  RETURN a * h / r;
END $$ LANGUAGE plpgsql;

