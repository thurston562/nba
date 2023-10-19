psql -d nba -f "/home/thurston323/nba/sql_nba/ml_table.sql"
gsutil rm gs://ml_basketball562/latest/*.csv 
TABLES='ml_basketball_full ml_basketball_train ml_basketball_predict'
for table in $TABLES
  do
    psql -d nba -c "\COPY ${table} TO '/home/thurston323/nba/csv_gcp/${table}.csv' with delimiter ',' CSV HEADER;"
  done
gsutil cp /home/thurston323/nba/csv_gcp/*.csv gs://ml_basketball562/latest/

