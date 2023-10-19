select date_game,
       player_name,
       floor(split_part(game_age,'-',1)::float * 365.25)::int + split_part(game_age,'-',2)::int as player_age,
       case opp_id
            when 'ATL' then 'Atlanta Hawks'
            when 'BOS' then 'Boston Celtics'
            WHEN 'BRK' then 'Brooklyn Nets'
            WHEN 'CHA' then 'Charlotte Hornets'
            WHEN 'CHH' then 'Charlotte Hornets'
            WHEN 'CHI' then 'Chicago Bulls'
            WHEN 'CHO' then 'Charlotte Hornets'
            WHEN 'CLE' then 'Cleveland Cavaliers'
            WHEN 'DAL' then 'Dallas Mavericks'
            WHEN 'DEN' then 'Denver Nuggets'
            WHEN 'DET' then 'Detroit Pistons'
            WHEN 'GSW' then 'Golden State Warriors'
            WHEN 'HOU' then 'Houston Rockets'
            WHEN 'IND' then 'Indiana Pacers'
            WHEN 'KCK' then 'Sacramento Kings'
            WHEN 'LAC' then 'Los Angeles Clippers'
            WHEN 'LAL' then 'Los Angeles Lakers'
            WHEN 'MEM' then 'Memphis Grizzlies'
            WHEN 'MIA' then 'Miami Heat'
            WHEN 'MIL' then 'Milwaukee Bucks'
            WHEN 'MIN' then 'Minnesota Timberwolves'
            WHEN 'NJN' then 'Brooklyn Nets'
            WHEN 'NOH' then 'New Orleans Pelicans'
            WHEN 'NOK' then 'New Orleans Pelicans'
            WHEN 'NOP' then 'New Orleans Pelicans'
            WHEN 'NYK' then 'New York Knicks'
            WHEN 'OKC' then 'Oklahoma City Thunder'
            WHEN 'ORL' then 'Orlando Magic'
            WHEN 'PHI' then 'Philadelphia 76ers'
            WHEN 'PHO' then 'Phoenix Suns'
            WHEN 'POR' then 'Portland Trail Blazers'
            WHEN 'SAC' then 'Sacramento Kings'
            WHEN 'SAS' then 'San Antonio Spurs'
            WHEN 'SDC' then 'Los Angeles Clippers'
            WHEN 'SEA' then 'Oklahoma City Thunder'
            WHEN 'TOR' then 'Toronto Raptors'
            WHEN 'UTA' then 'Utah Jazz'
            WHEN 'VAN' then 'Memphis Grizzlies'
            WHEN 'WAS' then 'Washington Wizards'
            WHEN 'WAB' then 'Washington Wizards'
       end opp,
       case team_id
            when 'ATL' then 'Atlanta Hawks'
            when 'BOS' then 'Boston Celtics'
            WHEN 'BRK' then 'Brooklyn Nets'
            WHEN 'CHA' then 'Charlotte Hornets'
            WHEN 'CHH' then 'Charlotte Hornets'
            WHEN 'CHI' then 'Chicago Bulls'
            WHEN 'CHO' then 'Charlotte Hornets'
            WHEN 'CLE' then 'Cleveland Cavaliers'
            WHEN 'DAL' then 'Dallas Mavericks'
            WHEN 'DEN' then 'Denver Nuggets'
            WHEN 'DET' then 'Detroit Pistons'
            WHEN 'GSW' then 'Golden State Warriors'
            WHEN 'HOU' then 'Houston Rockets'
            WHEN 'IND' then 'Indiana Pacers'
            WHEN 'KCK' then 'Sacramento Kings'
            WHEN 'LAC' then 'Los Angeles Clippers'
            WHEN 'LAL' then 'Los Angeles Lakers'
            WHEN 'MEM' then 'Memphis Grizzlies'
            WHEN 'MIA' then 'Miami Heat'
            WHEN 'MIL' then 'Milwaukee Bucks'
            WHEN 'MIN' then 'Minnesota Timberwolves'
            WHEN 'NJN' then 'Brooklyn Nets'
            WHEN 'NOH' then 'New Orleans Pelicans'
            WHEN 'NOK' then 'New Orleans Pelicans'
            WHEN 'NOP' then 'New Orleans Pelicans'
            WHEN 'NYK' then 'New York Knicks'
            WHEN 'OKC' then 'Oklahoma City Thunder'
            WHEN 'ORL' then 'Orlando Magic'
            WHEN 'PHI' then 'Philadelphia 76ers'
            WHEN 'PHO' then 'Phoenix Suns'
            WHEN 'POR' then 'Portland Trail Blazers'
            WHEN 'SAC' then 'Sacramento Kings'
            WHEN 'SAS' then 'San Antonio Spurs'
            WHEN 'SDC' then 'Los Angeles Clippers'
            WHEN 'SEA' then 'Oklahoma City Thunder'
            WHEN 'TOR' then 'Toronto Raptors'
            WHEN 'UTA' then 'Utah Jazz'
            WHEN 'VAN' then 'Memphis Grizzlies'
            WHEN 'WAS' then 'Washington Wizards'
            WHEN 'WAB' then 'Washington Wizards'
       end team_id,
       case when game_location = '@' then 'away' else 'home' end g_location,
       gs,      
       mp,
       fg,
       fga,
       fg_pct,
       game_three_made,
       game_three_att,
       game_three_perc,
       ft,
       fta,
       ft_pct,
       orb,
       drb,
       trb,
       ast,
       stl,
       blk,
       tov,
       pf,
       pts
from game_details
where date_game > '9/1/2000'::date
order by team_id,date_game,player_name
