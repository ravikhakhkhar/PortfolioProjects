select * FROM covidDeaths where continent is not null order by 3,4

select location,date,total_cases,new_cases,total_deaths,population from covidDeaths order by 1,2

--total cases vs total deaths
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage from covidDeaths where location like '%states%' order by 1,2


--looking at total cases vs population
--totl % population got covid
select location,date,total_cases,population,(total_cases/population)*100 as percentpopulationInfacted from covidDeaths order by 1,2

--looking at countries with highest infaction rate compare to population
select location,population,max(total_cases) as highestInfectedCountry,max(total_cases/population)*100 as percentpopulationInfacted from covidDeaths 
group by location,population 
order by percentpopulationInfacted desc

--counties with highest death count/population--
select location,max(cast (total_deaths as int)) as TotalDeathcount from covidDeaths where continent is not null group by location order by TotalDeathcount desc


--LETS BREAK EVERYTHING BY THE CONTINENT--extra
select location,max(cast (total_deaths as int)) as TotalDeathcount 
from covidDeaths 
where continent is  null 
group by location 
order by TotalDeathcount desc


--LETS BREAK EVERYTHING BY THE CONTINENT--main
--showing continent with highest death
select continent,max(cast (total_deaths as int)) as TotalDeathcount 
from covidDeaths 
where continent is  not null 
group by continent 
order by TotalDeathcount desc

--Global numbers
select SUM(new_cases) as totalcases,sum(cast(new_deaths as int)) as totaldeaths,(sum(cast(new_deaths as int))/SUM(new_cases))*100 as Deathpercentage from CovidDeaths
where continent is not null
--group by date
order by 1,2

--total population vs vaccination

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccination
from CovidDeaths as dea join CovidVaccinations as vac on 
dea.location=vac.location and
dea.date=vac.date
where dea.continent is not null
order by 2,3

--CTE
with PopVsVac(continent,location,date,population,new_vaccinations,RollingPeopleVaccination)
as 
(
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccination
from CovidDeaths as dea join CovidVaccinations as vac on 
dea.location=vac.location and
dea.date=vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccination/population)*100 as PercentpopolationVaccinated from PopVsVac




--CREATING VIEWS FOR VISUALIZATION 
CREATE VIEW PercentpopolationVaccinated as
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccination
from CovidDeaths as dea join CovidVaccinations as vac on 
dea.location=vac.location and
dea.date=vac.date
where dea.continent is not null
