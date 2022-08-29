select * from ipl

modify column Tournament year
alter table ipl
drop column tour_yea

select distinct(player) from ipl

with t1 as 
(select team,max(`Runds Scored`)as max_score,Tournament from ipl group by team,Tournament
)
select player,max_score,t1.Tournament,t1.Team from ipl,t1 where t1.max_score=ipl.`Runds Scored` order by ipl.Tournament

