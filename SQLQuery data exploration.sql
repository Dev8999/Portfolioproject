
Select *
From [covid death]
Where continent is not null 
order by 3,4
--select *
--From ['covid vaccine$']
--order by 3,4

-- Select Data that we are going to be starting with
select location, date, total_cases, new_cases, total_deaths, population 
From [covid death]
Where continent is not null 
order by 1,2

-- Total cases vs total deaths
-- Likelihood of dying due to covid in India

SELECT location, CONVERT(DATE, date) AS date, total_cases, total_deaths, (CONVERT(decimal, total_deaths)/CONVERT(decimal, total_cases))*100 AS DeathPercentage 
FROM [covid death]
Where location like '%states%'
and continent is not null 
order by 1,2


--looking at Total Cases vs population 
-- Shows what percentage of population infected with Covid



Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From [covid death]
Where continent is not null 
order by 1,2 

-- - Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [covid death]
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--showing countries with Highest Death count per Population
Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [covid death]
--Where location like '%states%'
Where continent is not null 
Group by location 
order by TotalDeathCount desc

--showing continenets with the highest death count per population 
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From [covid death]
--Where location like '%states%'
Where continent is not null 
Group by continent 
order by TotalDeathCount desc

-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [covid death]
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


-- Looking at Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, CONVERT(DATE,dea.date) AS date, dea.population, vac.new_vaccinations, 
		SUM(CONVERT(decimal,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM [covid death] AS dea
JOIN ['covid vaccine$'] AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2,3


-- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, CONVERT(DATE, dea.date) AS date, dea.population, vac.new_vaccinations
, SUM(CONVERT(decimal,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM [covid death] AS dea
JOIN ['covid vaccine$'] AS vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null 
)

SELECT *, (RollingPeopleVaccinated/Population)*100 AS RollingPeopleVaccinatedPercent
FROM PopvsVac
ORDER BY Location,Date

-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(decimal,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM [covid death] AS dea
JOIN ['covid vaccine$'] AS vac
	ON dea.location = vac.location
	AND dea.date = vac.date


SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [covid death] dea
Join ['covid vaccine$'] vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
 
