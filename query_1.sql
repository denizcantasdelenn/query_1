--Following queries are my own solutions to the questions mentioned in the youtube channel of Ankit Bansal.
--The link for his youtube channel is: https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=2
--My quries were given a name in the same order with his videos (query_1 for the first video etc).
--You can find the dataset for the questions in the commend block of the videos.
--I solved more than 50 problems and I find this youtube channel very helpful for my SQL learning journey!!!

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


--Find total number of matches, winnings and losses of the teams.

--select * from icc_world_cup

with all_teams as (
select Team_1 as teams
from icc_world_cup
union all
select Team_2 as teams
from icc_world_cup)
, total_matches as (
select teams, count(*) as total_matches
from all_teams
group by teams)
, no_wins as (
select Winner, 
sum((case when Team_1 = Winner then 1 else 0 end) + (case when Team_2 = Winner then 1 else 0 end)) as winnings
from icc_world_cup
group by Winner)

select tm.teams, tm.total_matches, 
case when nw.winnings is not null then nw.winnings else 0 end as no_of_wins, 
(total_matches - (case when nw.winnings is not null then nw.winnings else 0 end)) as no_of_losses
from total_matches tm
left join no_wins nw on tm.teams = nw.Winner