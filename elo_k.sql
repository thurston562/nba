CREATE OR REPLACE FUNCTION elo_k(MOV integer, elo_diff numeric)
RETURNS NUMERIC AS $$
DECLARE
  k NUMERIC := 20;
  multiplier NUMERIC;
BEGIN
  IF MOV > 0 THEN
    multiplier := power((MOV + 3), 0.8) / (7.5 + 0.006 * elo_diff);
  ELSE
    multiplier := power((-MOV + 3), 0.8) / (7.5 + 0.006 * (-elo_diff));
  END IF;

  RETURN k * multiplier;
END $$ LANGUAGE plpgsql;

