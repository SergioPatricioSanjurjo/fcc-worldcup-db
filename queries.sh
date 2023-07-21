#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo  "$($PSQL "SELECT SUM(winner_goals) + SUM(opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo  "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo  "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo  "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo  "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo  "$($PSQL "SELECT COUNT(winner_goals) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo  "$($PSQL "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round LIKE 'Final' AND year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT name FROM teams AS t1 
                FULL JOIN games AS gw ON t1.team_id = gw.winner_id 
                WHERE gw.year= 2014  AND gw.round LIKE 'Eighth-Final' 
                UNION
                SELECT name FROM teams AS t2 
                FULL JOIN games AS go ON t2.team_id = go.opponent_id 
                WHERE go.year= 2014  AND go.round LIKE 'Eighth-Final' 
                GROUP BY name
                ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "SELECT name FROM teams AS t 
                INNER JOIN games AS g ON t.team_id = g.winner_id
                GROUP BY name
                ORDER BY name")"
                

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT year, name FROM teams AS t 
                INNER JOIN games AS g ON t.team_id = g.winner_id
                WHERE round LIKE 'Final'
                ORDER BY year")";

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "SELECT name from teams AS t1
                INNER JOIN games AS gw ON t1.team_id = gw.winner_id
                WHERE t1.name LIKE 'Co%'
                UNION
                SELECT name from teams AS t2
                INNER JOIN games AS go ON t2.team_id = go.opponent_id
                WHERE t2.name LIKE 'Co%'
                GROUP BY name
                ORDER BY name")"

