select * from ['covidDeaths$']
order by 3 , 5

select * from ['covidVax$']
order by 3 , 4


select location, date, total_cases, total_deaths, population
from ['covidDeaths$']
order by 1,2

-- cases vs total death

select location, date, total_cases, total_deaths, (cast(total_deaths as float)/ total_cases)*100  as DeathPercentage
from ['covidDeaths$']
order by 1,2


-- cases versus population
--shows what percentage got covid
select location, date, total_cases, population, ( total_cases/population)*100  as infectionPercentage
from ['covidDeaths$']
--where location like '%states%'
order by 1,2




-- looking at countries with hightest infection rate compared to poplation

select location,  population, max(total_cases) as highestInfectionCount, max(( total_cases/population))*100  as infectionPercentage
from ['covidDeaths$']
--where location like '%states%'
group by location, population
order by infectionPercentage desc



-- showing countries with the highest death count per population

select location, max(cast(total_deaths as int)) as totaldeathCount
from ['covidDeaths$']
--where location like '%states%'
where continent is not null
group by location
order by totaldeathCount desc


select location, max(cast(total_deaths as int)) as totaldeathCount
from ['covidDeaths$']
--where location like '%states%'
where continent is null
group by location
order by totaldeathCount desc


-- Global numbers

select date, sum(new_cases) as totalNewCases, sum(cast(new_deaths as int))--, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathPercentage
from ['covidDeaths$']
--where location like '%states%'
where continent is not null
group by date
order by 1,2


select dea.continent, dea.location,dea.date, dea.population, vax.new_vaccinations 
from ['covidDeaths$'] dea
join ['covidVax$'] vax
on dea.location = vax.location
and dea.date = vax.date
where dea.continent is not null
order by 2,3


--total population vs vaccinations

select dea.continent, dea.location,dea.date, dea.population, vax.new_vaccinations,
sum(Convert(bigint, vax.new_vaccinations )) over (partition by dea.location)
from ['covidDeaths$'] dea
join ['covidVax$'] vax
on dea.location = vax.location
and dea.date = vax.date
where dea.continent is not null
order by 2,3

--use CTE

with PopsVac (Continent, Location, Date, Population, NewVac, RollingPeopleVac)
as
(
select dea.continent, dea.location,dea.date, dea.population, vax.new_vaccinations,
sum(Convert(bigint, vax.new_vaccinations )) over (partition by dea.location)
from ['covidDeaths$'] dea
join ['covidVax$'] vax
on dea.location = vax.location
and dea.date = vax.date
where dea.continent is not null
--order by 2,3
)

select * from PopsVac



-- Temp Table

drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location,dea.date, dea.population, vax.new_vaccinations,
sum(Convert(bigint, vax.new_vaccinations )) over (partition by dea.location)
from ['covidDeaths$'] dea
join ['covidVax$'] vax
on dea.location = vax.location
and dea.date = vax.date
where dea.continent is not null

select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated