create or replace view team_view_scores as
 WITH cte_gs AS (
         SELECT game_details.date_game AS cte_game_date,
            game_details.team_id,
            sum(COALESCE(game_details.game_score, 0::double precision)) AS game_score,
            game_details.date_game - lag(game_details.date_game) OVER (PARTITION BY game_details.team_id ORDER BY game_details.date_game) AS last_game
           FROM game_details
          WHERE game_details.date_game > '2000-09-19'::date
          GROUP BY game_details.date_game, game_details.team_id
        ), cte_gc AS (
         SELECT b.game_date,
            b.team_name,
            b.days_since_last_game
           FROM ( SELECT a.game_date,
                    a.team_name,
                    a.game_date - lag(a.game_date) OVER (PARTITION BY a.team_name ORDER BY a.game_date) AS days_since_last_game
                   FROM ( SELECT b_1.game_date,
                                CASE
                                    WHEN b_1.home = true THEN b_1.team
                                    ELSE b_1.opponent
                                END AS team_name
                           FROM game_matchup b_1
                        UNION
                         SELECT c.game_date,
                                CASE
                                    WHEN c.home = false THEN c.team
                                    ELSE c.opponent
                                END AS team_name
                           FROM game_matchup c) a) b
          WHERE b.game_date = CURRENT_DATE
          ORDER BY b.game_date
        )
 SELECT row_number() OVER (ORDER BY z."Date") AS "Game_ID",
    z."Date",
    z."Season",
    z."A_Team",
    z."A_Points",
    z."A_game_score",
    z."A_last_team_game",
    z."H_Team",
    z."H_Points",
    z."H_game_score",
    z."H_last_team_game"
   FROM ( SELECT a.game_date AS "Date",
            get_season(a.game_date) AS "Season",
            a.visitor_team AS "A_Team",
            a.visitor_score AS "A_Points",
            ( SELECT cte_gs.game_score
                   FROM cte_gs
                     JOIN team_name ON btrim(team_name.fullname) = btrim(a.visitor_team::text)
                  WHERE cte_gs.team_id::text = team_name.t_abbr AND cte_gs.cte_game_date = a.game_date) AS "A_game_score",
            ( SELECT cte_gs.last_game
                   FROM cte_gs
                     JOIN team_name ON btrim(team_name.fullname) = btrim(a.visitor_team::text)
                  WHERE cte_gs.team_id::text = team_name.t_abbr AND cte_gs.cte_game_date = a.game_date) AS "A_last_team_game",
            a.home_team AS "H_Team",
            a.home_score AS "H_Points",
            ( SELECT cte_gs.game_score
                   FROM cte_gs
                     JOIN team_name ON btrim(team_name.fullname) = btrim(a.home_team::text)
                  WHERE cte_gs.team_id::text = team_name.t_abbr AND cte_gs.cte_game_date = a.game_date) AS "H_game_score",
            ( SELECT cte_gs.last_game
                   FROM cte_gs
                     JOIN team_name ON btrim(team_name.fullname) = btrim(a.home_team::text)
                  WHERE cte_gs.team_id::text = team_name.t_abbr AND cte_gs.cte_game_date = a.game_date) AS "H_last_team_game"
           FROM game_summary a
          WHERE a.game_date > '2000-09-19'::date
        UNION
        ( SELECT b.game_date,
            get_season(b.game_date) AS season,
                CASE
                    WHEN b.home = true THEN b.opponent
                    ELSE b.team
                END AS visitor_team,
            NULL::integer AS visitor_score,
            NULL::double precision AS visitor_game_score,
            ( SELECT cte_gc.days_since_last_game
                   FROM cte_gc
                  WHERE ((( SELECT
                                CASE
                                    WHEN b.home = true THEN b.opponent
                                    ELSE b.team
                                END AS team))::text) = cte_gc.team_name::text) AS last_visitor_team_game,
                CASE
                    WHEN b.home = false THEN b.opponent
                    ELSE b.team
                END AS home_team,
            NULL::integer AS home_score,
            NULL::double precision AS home_game_score,
            ( SELECT cte_gc.days_since_last_game
                   FROM cte_gc
                  WHERE ((( SELECT
                                CASE
                                    WHEN b.home = true THEN b.team
                                    ELSE b.opponent
                                END AS opponent))::text) = cte_gc.team_name::text) AS last_home_team_game
           FROM game_matchup b
          WHERE b.game_date = CURRENT_DATE
          ORDER BY b.game_date)
  ORDER BY 1) z;


