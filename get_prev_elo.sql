CREATE OR REPLACE FUNCTION get_prev_elo(var_team text, date date, season text,location text)
RETURNS double precision
LANGUAGE plpgsql
AS $$
DECLARE
  prev_game record;
  elo_rating double precision;
BEGIN
  -- Finding the previous game record
  SELECT * INTO prev_game 
  FROM (
    SELECT *
    FROM latest_elo
    WHERE (team = var_team) 
    AND game_date < date
    ORDER BY game_date DESC LIMIT 1
  ) subq;

  -- Finding the elo rating
  IF location = 'H' THEN
    SELECT prev_game.home_elo_score INTO elo_rating;
  END IF;
  IF location = 'A' THEN
    SELECT prev_game.away_elo_score  INTO elo_rating;
  END IF;
  IF location = 'F' THEN 
    SELECT prev_game.full_elo_score INTO elo_rating;
  END IF;

  -- Return the elo rating with 0.75 weight if previous game season is different,
  -- and with 0.25 weight if it's the same
  IF prev_game.Season != season THEN
    RETURN (0.75 * elo_rating) + (0.25 * 1505);
  ELSE
    RETURN elo_rating;
  END IF;
END $$ ;


