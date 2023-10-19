import math
import psycopg2
import pandas as pd
from sqlalchemy import create_engine

def win_probs(home_elo, away_elo, home_court_advantage) :
  h = math.pow(10, home_elo/400)
  r = math.pow(10, away_elo/400)
  a = math.pow(10, home_court_advantage/400) 

  denom = r + a*h
  home_prob = a*h / denom
  away_prob = r / denom 
  
  return home_prob, away_prob

  #odds the home team will win based on elo ratings and home court advantage

def home_odds_on(home_elo, away_elo, home_court_advantage) :
  h = math.pow(10, home_elo/400)
  r = math.pow(10, away_elo/400)
  a = math.pow(10, home_court_advantage/400)
  return a*h/r

#this function determines the constant used in the elo rating, based on margin of victory and difference in elo ratings
def elo_k(MOV, elo_diff):
  k = 20
  if MOV>0:
      multiplier=(MOV+3)**(0.8)/(7.5+0.006*(elo_diff))
  else:
      multiplier=(-MOV+3)**(0.8)/(7.5+0.006*(-elo_diff))
  return k*multiplier


#updates the home and away teams elo ratings after a game 

def update_elo(home_score, away_score, home_elo, away_elo, home_court_advantage) :
  home_prob, away_prob = win_probs(home_elo, away_elo, home_court_advantage) 

  if (home_score - away_score > 0) :
    home_win = 1 
    away_win = 0 
  else :
    home_win = 0 
    away_win = 1 
  
  k = elo_k(home_score - away_score, home_elo - away_elo)

  updated_home_elo = home_elo + k * (home_win - home_prob) 
  updated_away_elo = away_elo + k * (away_win - away_prob)

  return updated_home_elo, updated_away_elo


#takes into account prev season elo
def get_prev_elo(team, date, season, team_stats, elo_df) :
  prev_game = team_stats[team_stats['Date'] < game_date][(team_stats['H_Team'] == team) | (team_stats['A_Team'] == team)].sort_values(by = 'Date').tail(1).iloc[0] 

  if team == prev_game['H_Team'] :
    elo_rating = elo_df[elo_df['Game_ID'] == prev_game['Game_ID']]['H_Team_Elo_After'].values[0]
  else :
    elo_rating = elo_df[elo_df['Game_ID'] == prev_game['Game_ID']]['A_Team_Elo_After'].values[0]
  
  if prev_game['Season'] != season :
    return (0.75 * elo_rating) + (0.25 * 1505)
  else :
    return elo_rating



# Create an engine instance

alchemyEngine   = create_engine('postgresql+psycopg2://thurston323:Ballin!3748@localhost/nba', pool_recycle=3600);

# Connect to PostgreSQL server

dbConnection    = alchemyEngine.connect();

# Read data from PostgreSQL database table and load into a DataFrame instance

team_stats = pd.read_sql("select * from team_summary_view where \"Date\" > '2000-10-19'", dbConnection);
pd.set_option('display.expand_frame_repr', False);

# Print the DataFrame

print(team_stats);
game_stats = pd.read_sql("select * from team_view_scores where \"Date\" > '2000-10-19'", dbConnection);
print(game_stats);

team_stats.sort_values(by = 'Date', inplace = True)
team_stats.reset_index(inplace=True, drop = True)
elo_df = pd.DataFrame(columns=['Game_ID', 'H_Team', 'A_Team', 'H_Team_Elo_Before', 'A_Team_Elo_Before', 'H_Team_Elo_After', 'A_Team_Elo_After'])
teams_elo_df = pd.DataFrame(columns=['Game_ID','Team', 'Elo', 'Date', 'Where_Played', 'Season']) 

for index, row in team_stats.iterrows(): 
  game_id = row['Game_ID']
  game_date = row['Date']
  season = row['Season']
  h_team, a_team = row['H_Team'], row['A_Team']
  h_score, a_score = row['H_Points'], row['A_Points'] 

  if (h_team not in elo_df['H_Team'].values and h_team not in elo_df['A_Team'].values) :
    h_team_elo_before = 1500
  else :
    h_team_elo_before = get_prev_elo(h_team, game_date, season, team_stats, elo_df)

  if (a_team not in elo_df['H_Team'].values and a_team not in elo_df['A_Team'].values) :
    a_team_elo_before = 1500
  else :
    a_team_elo_before = get_prev_elo(a_team, game_date, season, team_stats, elo_df)

  h_team_elo_after, a_team_elo_after = update_elo(h_score, a_score, h_team_elo_before, a_team_elo_before, 69)

  new_row = {'Game_ID': game_id, 'H_Team': h_team, 'A_Team': a_team, 'H_Team_Elo_Before': h_team_elo_before, 'A_Team_Elo_Before': a_team_elo_before, \
                                                                        'H_Team_Elo_After' : h_team_elo_after, 'A_Team_Elo_After': a_team_elo_after}
  teams_row_one = {'Game_ID': game_id,'Team': h_team, 'Elo': h_team_elo_before, 'Date': game_date, 'Where_Played': 'Home', 'Season': season}
  teams_row_two = {'Game_ID': game_id,'Team': a_team, 'Elo': a_team_elo_before, 'Date': game_date, 'Where_Played': 'Away', 'Season': season}
  
  elo_df = elo_df.append(new_row, ignore_index = True)
  teams_elo_df = teams_elo_df.append(teams_row_one, ignore_index=True)
  teams_elo_df = teams_elo_df.append(teams_row_two, ignore_index=True)
print(teams_elo_df[-30:])
print(game_stats[-30:])
full_stats_df = teams_elo_df[teams_elo_df['Where_Played']=='Away'].merge(game_stats.loc[0:,['Date','A_Team','A_Points','A_game_score','A_last_team_game']],left_on=['Date','Team'],right_on=['Date','A_Team'])
full_stats_df.rename(columns={"A_Points": "Points","A_game_score": "game_score","A_last_team_game":"last_team_game"},inplace=True)
full_stats_df.drop(columns='A_Team',inplace=True)
home_stats_df = teams_elo_df[teams_elo_df['Where_Played']=='Home'].merge(game_stats.loc[0:,['Date','H_Team','H_Points','H_game_score','H_last_team_game']],left_on=['Date','Team'],right_on=['Date','H_Team'])
home_stats_df.rename(columns={"H_Points": "Points","H_game_score": "game_score","H_last_team_game":"last_team_game"},inplace=True)
home_stats_df.drop(columns='H_Team',inplace=True)
full_stats_df = full_stats_df.append(home_stats_df, ignore_index=True)
pd.set_option('display.max_rows',full_stats_df.shape[0] + 1)
full_stats_df.sort_values('Game_ID',inplace=True)
print(full_stats_df)
full_stats_df.to_sql('elo_score_table',alchemyEngine)
dbConnection.close();

