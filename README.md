Covid-Data-Analysis-using-SQL

COVID-19 took a toll on everyone's lives and was unfortunate that it took the lives of many people across the world. The thought behind choosing this dataset was to explore the data and take
note of the countries which experience most number of deaths of the infected people and the perecentage of population who are affected and vaccinated to fight the virus.

Rows: 87743 Columns: 59

Many null values were found in the dataset. This has been taken into consideration during the analysis

Continent column contains names of continents. Location column contains names of continents and countries.
While analyzing country wise data, it is important to exclude rows with location set to continent name.Example:

SELECT location, MAX(total_cases)
FROM covid19timeseries
WHERE continent IS NOT NULL

mporting Dataset Into SQL Server
It is recommended that SQL Server Import and Export Data (64 bit) wizard is launched from the Start Menu, and not the inbuilt option available within SSMS

Analysis
List Of Countries Affected By Covid19
Number Of Countries Affected By Covid19
Date Of First Case Reported For Each Country
Total Cases Vs Total Deaths (All Countries) - Observing Change With Time
Total Case Vs Total Deaths (India) - Observing Change With Time
CASES_SUMMARY: Isolating Total Cases, Total Deaths For Each Country
Cases And Deaths Compared To Population
Cases And Deaths Compared To Population (India)
Highest To Lowest Death Count
Cases And Deaths - Continent Wise
Vaccination Start Date For Countries
Total No. Of People Vaccinated, Vaccination Percentage Of Population
TOP 5 countries with most people vaccinated (United States, India, United Kingdom)
Comparing Diabetes Prevalence, Cardiovascular Death Rate To Death Percentage
Comparing Stringency Index to Infected Population And Death Percentage
Comparing Smokers to Infected Population And Death Percentage
Comparing Percentage Of Population Over 65 And 70 To Infected Population And Death Percentage
Comparing GDP, Human Development Index, Extreme Poverty To Vaccinated Population Percentage
Correlation Between New Vaccinations And New Cases For Top 5 Countries with Highest Count Of Vaccination
Correlation Between New Vaccinations And New Deaths For Top 5 Countries with Highest Count Of Vaccination
Correlation Between New Vaccinations And Stringency Index For Top 5 Countries with Highest Count Of Vaccination
