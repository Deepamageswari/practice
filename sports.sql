select * from stadium;
select * from team;
select * from match;
select * from team_owners;
select * from players;
select * from team_player;
--Find the team names to which player Kohli played.
select team_nm from team where team_id in 
(select team_id from team_player where player_id=
(select player_id from players where player_nm='Kohli'));
--Display the current team to which Marian is playing for.
select team_nm from team where team_id in 
(select team_id from team_player
where player_id =(select player_id from players where player_nm= 'Kohli')
and 
end_date = (select max(end_date) from team_player t inner join players p on p.player_id = t.player_id
where t.player_id =(select player_id from players where player_nm= 'Kohli')));

select p.player_id,t.team_id from players p inner join team_player t on 
p.player_id = t.player_id where p.player_nm='Marian' and t.end_date=sysdate;

select p.player_id,t.team_id from players p 
inner join team_player t on p.player_id=t.player_id
where t.end_date>sysdate and p.player_nm='Marian';

--Find the number of players we have who is older than player Surendra
select count(player_id) from players where player_dob <
(select player_dob from players where player_nm ='Surendra');

--Display team name and total contract value of players for that team.
select m.team_nm,t.team_id,sum(contract_value) from team_player t
inner join team m on t.team_id=m.team_id 
group by (t.team_id,m.team_nm);

--Display the team_name, player_name, start_date, end_date and the contract value
select m.team_nm,p.player_nm,t.start_date,t.end_date,t.contract_value from players p
inner join team_player t on p.player_id=t.player_id
inner join team m on m.team_id=t.team_id;

--Display all the players who were born in the month of April
select player_nm from players where to_char(player_dob,'mon')='apr';

--Display all the players whose age is greater than 25 and who are either Grade B or Grade C Players
select p.player_nm,p.player_id,round(to_char(sysdate-player_dob)/365) from players p
inner join team_player t on p.player_id=t.player_id where 
round(to_char(sysdate-p.player_dob)/365)>25 and t.GRADE in ('A','B');

--Display the player_name, team_name and team's manager name for all the cricket players
select p.player_nm,m.team_nm,m.manager from players p
inner join team_player t on p.player_id=t.player_id
inner join team m on t.team_id=m.team_id;

--Display the stadium_name, match_date, home_team_name, player_name (consider only home team players)
select sta_name,match_date,home_team_id,player_nm from players p
inner join team_player t on p.player_id=t.player_id
inner join match m on m.visiting_team_id=t.team_id
inner join stadium s on m.sta_id=s.sta_id_;

--Create view which gives the players and their current association team. 
--If the sysdate is between the start_Date and end_date that means they are working for that team.
create view team_players as (select p.player_nm,t.team_id from players p 
inner join team_player t on p.player_id=t.player_id
where end_date>=sysdate);
select * from team_players;
drop view team_players;






SELECT TO_CHAR(TO_DATE(TRUNC(SYSDATE,'MM'),'DD-MM-YY')+(LEVEL-1),'DAY') "DAYS IN MONTH"
FROM DUAL
CONNECT BY LEVEL <= 10;




