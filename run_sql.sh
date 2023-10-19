psql -d nba -f ../sql_nba/game_summary_view_same.sql
psql -d nba -f ../sql_nba/game_summary_view_elo_west.sql
psql -d nba -f ../sql_nba/game_summary_view_elo_overall.sql
psql -d nba -f ../sql_nba/game_summary_view_elo_east.sql
psql -d nba -c "select update_basketball_elo_ratings();"
