CREATE OR REPLACE FUNCTION calculate_elo_score(
  k INTEGER,
  rating1 INTEGER,
  rating2 INTEGER,
  score1 NUMERIC,
  score2 NUMERIC
)
RETURNS INTEGER AS $$
DECLARE
  expected1 NUMERIC;
  expected2 NUMERIC;
  new_rating1 INTEGER;
  new_rating2 INTEGER;
BEGIN
  expected1 := 1 / (1 + 10^((rating2 - rating1) / 400));
  expected2 := 1 / (1 + 10^((rating1 - rating2) / 400));
  new_rating1 := rating1 + (k * (score1 - expected1));
  new_rating2 := rating2 + (k * (score2 - expected2));
  RETURN new_rating1;
END;
$$ LANGUAGE plpgsql;
