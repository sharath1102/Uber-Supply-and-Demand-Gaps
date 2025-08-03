use Labmentics;
select * from Uber;

-- Demand Insights Questions

-- 1.At what hours is ride demand highest and lowest?
select Request_Hour, count(*) as total_requests
from Uber
group by Request_Hour
order by total_requests desc;

-- 2.What are the peak demand periods for each pickup point?
-- Example: Find the top 3 busiest pickup points and their peak hours.
SELECT Pickup_point, Request_Hour, total_requests
FROM (
    SELECT TOP 3 Pickup_point, Request_Hour, COUNT(*) AS total_requests
    FROM Uber
    WHERE Pickup_point = 'Airport'
    GROUP BY Pickup_point, Request_Hour
    ORDER BY total_requests DESC
) AS AirportTop

UNION ALL

SELECT Pickup_point, Request_Hour, total_requests
FROM (
    SELECT TOP 3 Pickup_point, Request_Hour, COUNT(*) AS total_requests
    FROM Uber
    WHERE Pickup_point = 'City'
    GROUP BY Pickup_point, Request_Hour
    ORDER BY total_requests DESC
) AS CityTop
ORDER BY Pickup_point, total_requests DESC;



-- 3. How many requests are being placed vs. how many are fulfilled?
SELECT 
  (SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS fulfillment_ratio
FROM Uber;

-- 4. Trends of ride requests over time
SELECT 
    CONVERT(DATE, Request_timestamp) AS request_date,
    COUNT(*) AS total_requests
FROM Uber
GROUP BY CONVERT(DATE, Request_timestamp)
ORDER BY request_date;


-- Supply Insights

-- 1. What is the average response time (wait time) per driver or pickup point?
SELECT 
    Driver_id,
    AVG(DATEDIFF(MINUTE, Request_timestamp, Drop_timestamp)) AS Avg_Response_Time_Minutes
FROM Uber
WHERE Drop_timestamp IS NOT NULL
GROUP BY Driver_id;



-- 2. Which drivers are handling the most ride requests?
SELECT Driver_id, COUNT(*) AS Completed_Rides
FROM Uber
WHERE Status = 'Completed'
GROUP BY Driver_id
ORDER BY Completed_Rides DESC;


-- 3.Match between demand and driver availability
SELECT 
    Request_Hour, 
    COUNT(DISTINCT Driver_id) AS Unique_Drivers,
    COUNT(*) AS Total_Requests
FROM Uber
GROUP BY Request_Hour
ORDER BY Request_Hour;


-- 4.Supply shortfall periods. 
--Example: During which hours or at which pickup points are the most requests marked as 'Cancelled' or 'No Driver Available'?
SELECT Request_Hour, Pickup_point, COUNT(*) AS No_Driver_Requests
FROM Uber
WHERE Status = 'No Driver Available'
GROUP BY Request_Hour, Pickup_point
ORDER BY No_Driver_Requests DESC;



-- Combined Demand & Supply

-- 1. Unfulfilled Demand Analysis
-- Example: Which hours/locations have the highest rate of cancelled or unassigned requests?
SELECT 
    Request_Hour, 
    Pickup_point,
    COUNT(*) AS Total_Requests,
    SUM(CASE WHEN Status IN ('Cancelled', 'No Driver Available') THEN 1 ELSE 0 END) AS Unfulfilled_Requests,
    CAST(SUM(CASE WHEN Status IN ('Cancelled', 'No Driver Available') THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS Unfulfilled_Percentage
FROM Uber
GROUP BY Request_Hour, Pickup_point
ORDER BY Unfulfilled_Percentage DESC;


-- 2.Service Level Analysis
-- Example: What percentage of ride requests are fulfilled within X minutes?
SELECT 
    COUNT(*) AS Total_Requests,
    SUM(CASE WHEN DATEDIFF(MINUTE, Request_timestamp, Drop_timestamp) <= 10 AND Status = 'Completed' THEN 1 ELSE 0 END) AS Fulfilled_Within_10min,
    CAST(SUM(CASE WHEN DATEDIFF(MINUTE, Request_timestamp, Drop_timestamp) <= 10 AND Status = 'Completed' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) * 100 AS Fulfilled_Percentage_Within_10min
FROM Uber
WHERE Drop_timestamp IS NOT NULL;
