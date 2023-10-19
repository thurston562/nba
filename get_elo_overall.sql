WITH RECURSIVE p(current_game_number) AS (
  WITH players AS (
    SELECT DISTINCT home_team AS home_team_name
    FROM game_sum_view_elo
    where season = '2020-21'
    UNION
    SELECT DISTINCT visitor_team
    FROM game_sum_view_elo
    where season = '2020-21'
  )
  SELECT
    0::bigint               AS game_number,
    home_team_name,
    1000.0 :: FLOAT AS previous_elo,
    1000.0 :: FLOAT AS new_elo
  FROM players
  UNION ALL
  (
    WITH previous_elos AS (
        SELECT *
        FROM p
    )
    SELECT
      game_sum_view_elo.game_number,
      home_team_name,
      previous_elos.new_elo AS previous_elo,
      round(CASE WHEN home_team_name NOT IN (home_team, visitor_team)
        THEN previous_elos.new_elo
            WHEN home_team_name = home_team
              THEN previous_elos.new_elo + 32.0 * (home_score - (r1 / (r1 + r2)))
            ELSE previous_elos.new_elo + 32.0 * (visitor_score - (r2 / (r1 + r2))) END)
    FROM game_sum_view_elo
      JOIN previous_elos
        ON current_game_number = game_sum_view_elo.game_number - 1
      JOIN LATERAL (
           SELECT
             pow(10.0, (SELECT new_elo
                        FROM previous_elos
                        WHERE current_game_number = game_sum_view_elo.game_number - 1 AND home_team_name = home_team) / 400.0) AS r1,
             pow(10.0, (SELECT new_elo
                        FROM previous_elos
                        WHERE current_game_number = game_sum_view_elo.game_number - 1 AND home_team_name = visitor_team) / 400.0) AS r2
           ) r
        ON TRUE 
  )
)
SELECT
  home_team_name,
  (
    SELECT new_elo
    FROM p
    WHERE t.home_team_name = p.home_team_name
    ORDER BY current_game_number DESC
    LIMIT 1
  )                    AS elo,
  count(CASE WHEN previous_elo < new_elo
    THEN 1
        ELSE NULL END) AS wins,
  count(CASE WHEN previous_elo > new_elo
    THEN 1
        ELSE NULL END) AS losses
FROM
  (
    SELECT *
    FROM p
    WHERE previous_elo <> new_elo
    ORDER BY current_game_number, home_team_name
  ) t
GROUP BY home_team_name
ORDER BY elo DESC;
