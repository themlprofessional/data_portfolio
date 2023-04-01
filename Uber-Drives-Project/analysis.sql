-- Questions to ask the dataset

-- 1. What is the total number of cab rides for each category (business/personal)?

-- Business cabs are not only used more but also travelled mose distance
SELECT CATEGORY, COUNT(*) AS rides_count, SUM(MILES) AS total_miles
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY CATEGORY;


--------------------------------------------------------------------------------------------------------------------------


-- 2. What is the total number of round trips for each month?

-- round trips are more in december month
SELECT MONTH(START_DATE) AS month, COUNT(*) AS round_trip_count
FROM [UberDrives].[dbo].[UberDrives]
WHERE START = STOP AND MONTH(START_DATE) = 12
GROUP BY MONTH(START_DATE);


--------------------------------------------------------------------------------------------------------------------------


-- 3. What is the beast month for raising fare?

-- December can be the best month for earning profit by raising fare as demand is more
SELECT TOP 1 MONTH(START_DATE) AS month, COUNT(*) AS ride_count
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY MONTH(START_DATE)
ORDER BY ride_count DESC;


--------------------------------------------------------------------------------------------------------------------------


-- 4. Is there a noticeable trend in the number of cab rides per month?

-- There is a seasonal pattern in cab rides, with December having the highest demand.
SELECT DATEADD(month, DATEDIFF(month, 0, START_DATE), 0) AS [Month], COUNT(*) AS [Number of Rides]
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY DATEADD(month, DATEDIFF(month, 0, START_DATE), 0)
ORDER BY [Month];


--------------------------------------------------------------------------------------------------------------------------


-- 5. What are the top 5 cities with the highest number of cab rides?

SELECT TOP 5 START AS 'City', COUNT(*) AS 'Number of Rides'
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY START
ORDER BY COUNT(*) DESC;


--------------------------------------------------------------------------------------------------------------------------


-- 6. What is the distribution of miles and time taken for cab rides?

-- Most of the cab rides are within a distance of 35 miles taking about 30 minutes
SELECT 
    COUNT(*) AS 'Number of Rides', 
    CAST(MILES AS DECIMAL(10,2)) AS 'Miles', 
    CAST(DATEDIFF(MINUTE, CONVERT(DATETIME, START_DATE), CONVERT(DATETIME, END_DATE)) AS DECIMAL(10,2)) AS 'Time Taken (Minutes)'
FROM 
    [UberDrives].[dbo].[UberDrives]
GROUP BY 
    MILES, 
    CAST(DATEDIFF(MINUTE, CONVERT(DATETIME, START_DATE), CONVERT(DATETIME, END_DATE)) AS DECIMAL(10,2))
ORDER BY 
    MILES DESC;

-- For 10 miles it wil, it will take atleast 30 minutes
SELECT 
    COUNT(*) AS 'Number of Rides', 
    CAST(MILES AS DECIMAL(10,2)) AS 'Miles', 
    CAST(DATEDIFF(MINUTE, CONVERT(DATETIME, START_DATE), CONVERT(DATETIME, END_DATE)) AS DECIMAL(10,2)) AS 'Time Taken (Minutes)'
FROM 
    [UberDrives].[dbo].[UberDrives]
GROUP BY 
    MILES, 
    CAST(DATEDIFF(MINUTE, CONVERT(DATETIME, START_DATE), CONVERT(DATETIME, END_DATE)) AS DECIMAL(10,2))
ORDER BY 
    [Time Taken (Minutes)] DESC;


--------------------------------------------------------------------------------------------------------------------------


-- 7. What is the average time taken for airport rides compared to non-airport rides?

-- Cab rides to and from airports take more time compared to non-airport rides
-- Airport/Travel
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Airport%'
GROUP BY PURPOSE;

-- Meal/Entertain
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Meal%'
GROUP BY PURPOSE;

-- Errand/Supplies
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Errand%'
GROUP BY PURPOSE;

-- Meeting
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Meeting%'
GROUP BY PURPOSE;

-- Customer Visit
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Customer Visit%'
GROUP BY PURPOSE;

-- Temporary Site
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Temporary Site%'
GROUP BY PURPOSE;

-- Between Offices
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Between Offices%'
GROUP BY PURPOSE;

-- Charity ($)
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Charity%'
GROUP BY PURPOSE;

-- Commute
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Commute%'
GROUP BY PURPOSE;

-- Moving
SELECT PURPOSE, AVG(DATEDIFF(minute, START_DATE, END_DATE)) AS AVERAGE_MINUTES
FROM [UberDrives].[dbo].[UberDrives]
WHERE PURPOSE LIKE '%Moving%'
GROUP BY PURPOSE;


--------------------------------------------------------------------------------------------------------------------------


-- 8. What is the highest pickup point?

-- The highest pick-up point location is Cary
SELECT TOP 1 start, COUNT(*) AS pickups 
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY start 
ORDER BY pickups DESC;


--------------------------------------------------------------------------------------------------------------------------


-- 9. What is the busiest hour?

-- The busiest hour is 1 PM to 4 PM
SELECT
DATEPART(hh,START_DATE) AS Hour,
COUNT(*) AS UberOrders
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY DATEPART(hh,START_DATE)
ORDER BY COUNT(*) DESC


--------------------------------------------------------------------------------------------------------------------------


-- 10. What is day of the week with most and least TripCount

-- The day of the week with most TripCount is Friday, and the least is being Wednesday.
SELECT
DATENAME(weekday, Start_Date) AS DayName,
COUNT(*) AS TripCount
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY DATENAME(weekday, Start_Date)
ORDER BY TripCount DESC


--------------------------------------------------------------------------------------------------------------------------


-- 11. Where are the majority of trips occur between ?

-- The majority of trips originate and end between Cary and Morrisville.
SELECT TOP 2
START, STOP
FROM [UberDrives].[dbo].[UberDrives]
GROUP BY START, STOP
ORDER BY COUNT(*) DESC;