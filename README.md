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


