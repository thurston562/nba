CREATE OR REPLACE FUNCTION fix_team(team text)
   RETURNS TEXT IMMUTABLE AS $$
    BEGIN
         RETURN CASE  team WHEN 'New Jersey Nets' THEN  'Brooklyn Nets'
                           WHEN 'Charlotte Bobcats' THEN 'Charlotte Hornets'
                          WHEN 'Vancouver Grizzlies' THEN  'Memphis Grizzlies'
                          WHEN 'New Orleans Hornets' THEN  'New Orleans Pelicans'
                          WHEN 'New Orleans/Oklahoma City Hornets' THEN  'New Orleans Pelicans'
                          WHEN 'Seattle SuperSonics' THEN 'Oklahoma City Thunder'
                ELSE
                      team
                  END;
     END;
   $$
     LANGUAGE plpgsql;
