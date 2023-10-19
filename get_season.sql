CREATE OR REPLACE FUNCTION get_season(game_date date)
   RETURNS TEXT IMMUTABLE AS $$
    BEGIN
         RETURN CASE  when (game_date > '2000-10-30' and game_date < '2001-09-30')    THEN  '2000-01'
                      when (game_date > '2001-10-29' and game_date < '2002-09-29')    THEN  '2001-02'
                      when (game_date > '2002-10-28' and game_date < '2003-09-30')    THEN  '2002-03'
                      when (game_date > '2003-10-27' and game_date < '2004-09-30')    THEN  '2003-04'
                      when (game_date > '2004-10-30' and game_date < '2005-09-30')    THEN  '2004-05'
                      when (game_date > '2005-10-30' and game_date < '2006-09-30')    THEN  '2005-06'
                      when (game_date > '2006-10-30' and game_date < '2007-09-30')    THEN  '2006-07'
                      when (game_date > '2007-10-29' and game_date < '2008-09-30')    THEN  '2007-08'
                      when (game_date > '2008-10-27' and game_date < '2009-09-30')    THEN  '2008-09'
                      when (game_date > '2009-10-26' and game_date < '2010-09-30')    THEN  '2009-10'
                      when (game_date > '2010-10-25' and game_date < '2011-09-30')    THEN  '2010-11'
                      when (game_date > '2011-10-30' and game_date < '2012-09-30')    THEN  '2011-12'
                      when (game_date > '2012-10-26' and game_date < '2013-09-30')    THEN  '2012-13'
                      when (game_date > '2013-10-28' and game_date < '2014-09-30')    THEN  '2013-14'
                      when (game_date > '2014-10-27' and game_date < '2015-09-30')    THEN  '2014-15'
                      when (game_date > '2015-10-26' and game_date < '2016-09-30')    THEN  '2015-16'
                      when (game_date > '2016-10-24' and game_date < '2017-09-30')    THEN  '2016-17'
                      when (game_date > '2017-10-16' and game_date < '2018-09-30')    THEN  '2017-18'
                      when (game_date > '2018-10-15' and game_date < '2019-09-30')    THEN  '2018-19'
                      when (game_date > '2019-10-21' and game_date < '2020-11-29')    THEN  '2019-20'
                      when (game_date > '2020-11-30' and game_date < '2021-10-01')    THEN  '2020-21'
                      when (game_date > '2021-10-02' and game_date < '2022-09-30')    THEN  '2021-22'
                      when (game_date > '2022-10-10' and game_date < '2023-09-30')    THEN  '2022-23'
                      when (game_date > '2023-10-10' and game_date < '2024-09-30')    Then  '2023-24'

                                 
                
                      
                  END;
     END;
   $$
     LANGUAGE plpgsql;
