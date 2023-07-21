#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE teams, games"); # TRUNCATE TABLES FOR TEST

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  if [[ $year != 'year' ]]
  then
    # get team id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner' ")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent' ")
    # if not found
    if [[ -z $WINNER_ID ]] 
    then
      # insert team if winner
      WINNER_ID=$($PSQL "INSERT INTO teams(name) VALUES ('$winner')")
    fi

    if [[ -z $OPPONENT_ID ]]
    then
     # isert team if opponent
      OPPONENT_ID=$($PSQL "INSERT INTO teams(name) VALUES ('$opponent')")
    fi

    # insert games
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner' ")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent' ")
    GAMES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals)")
  fi
done



