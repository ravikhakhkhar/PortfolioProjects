select * from ipl

modify column Tournament year
alter table ipl
drop column tour_yea

select distinct(player) from ipl

with t1 as 
(select team,max(`Runds Scored`)as max_score,Tournament from ipl group by team,Tournament
)
select player,max_score,t1.Tournament,t1.Team from ipl,t1 where t1.max_score=ipl.`Runds Scored` order by ipl.Tournament

use  ipl_stats
select * from ipl
-- highest Wickets taker for delhi derdavils

select * from ipl where Team='Delhi Daredevils'
order by Tournament

-- yearwise highest wickets taker for delhi daredevils
with tb as
(
select tournament,max(`Wickets Taken`) as highest_wick from ipl  where Team='Delhi Daredevils' group by tournament)
select Player,tb.tournament,tb.highest_wick from tb join ipl on tb.highest_wick=ipl.`Wickets Taken` where ipl.Team='Delhi Daredevils' 

-- highest strikrate and his number of sixes

select player,`Batting Strike Rate`,6s from ipl where `Batting Strike Rate`=(select max(`Batting Strike Rate`) from ipl) 

-- hundreds in ipl by years
select player,team,`100`,tournament from ipl where `100`!=0 order by tournament,`100` desc

-- most matches played by players(team wise)
with tb as(
select player,team,sum(Matches) as sm from ipl group by player,team order by team,sum(Matches) desc
)
select player,team, max(sm) from tb group by team

