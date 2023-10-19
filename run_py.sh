psql -d nba -c "drop table elo_score_table" 
python calculate_elo.py
psql -d nba -f /home/thurston323/nba/sql_nba/game_sum_table.sql
psql -d nba -f /home/thurston323/nba/sql_nba/team_stats.sql
psql -d nba -f /home/thurston323/nba/sql_nba/elo_table_update.sql
