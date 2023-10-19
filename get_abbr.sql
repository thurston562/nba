CREATE OR REPLACE FUNCTION get_abbr(abbr text)
   RETURNS TEXT IMMUTABLE AS $$
    BEGIN
         RETURN CASE  abbr WHEN 'NOK' THEN  'NOP'
                           WHEN 'NOH' THEN 'NOP'
                          WHEN 'VAN' THEN  'MEM'
                          WHEN 'NJN' THEN  'BRK'
                          WHEN 'SDC' THEN  'LAC'
                          WHEN 'CHA' THEN 'CHO'
                          WHEN 'CHH' THEN  'CHO'
                          WHEN 'KCK' THEN 'SAC'
                          WHEN 'SEA' THEN 'OKC'
                          WHEN 'WSB' THEN 'WAS'
                ELSE
                      abbr
                  END;
     END;
   $$
     LANGUAGE plpgsql;
