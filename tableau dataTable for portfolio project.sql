--1)


select SUM(new_cases) as totalcases,sum(cast(new_deaths as int)) as totaldeaths,(sum(cast(new_deaths as int))/SUM(new_cases))*100 as Deathpercentage from CovidDeaths
where continent is not null
--group by date
order by 1,2


--2)
select location,sum(cast(new_deaths as int)) as totalDeathcount 
from covidDeaths
where continent is null
and location not in ('International','European Union','World')
group by location
order by totalDeathcount desc

--3)
select location,population,max(total_cases) as highestInfectedCountry,max(total_cases/population)*100 as percentpopulationInfacted from covidDeaths 
group by location,population 
order by percentpopulationInfacted desc

--4)
select location,population,date,max(total_cases) as highestInfectedCountry,max(total_cases/population)*100 as percentpopulationInfacted from covidDeaths 
group by location,population,date
order by percentpopulationInfacted desc