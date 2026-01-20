-- Smart City Energy Consumption Analysis
-- Database: business_case
-- Table: smart_city_energy

-- 1. Total and average daily energy consumption by zone
SELECT 
    Zone,
    DATE(Date) AS Day,
    SUM(EnergyConsumed_kWh) AS Total_Energy,
    AVG(EnergyConsumed_kWh) AS Avg_Energy
FROM smart_city_energy
GROUP BY Zone, Day;

-- 2. Top 5 highest energy-consuming consumers by type
SELECT 
    ConsumerType,
    MeterID,
    SUM(EnergyConsumed_kWh) AS Total_Energy
FROM smart_city_energy
GROUP BY ConsumerType, MeterID
ORDER BY Total_Energy DESC
LIMIT 5;

-- 3. Monthly trend of energy consumption across zones
SELECT 
    Zone,
    DATE_FORMAT(Date,'%Y-%m') AS Month,
    SUM(EnergyConsumed_kWh) AS Monthly_Energy
FROM smart_city_energy
GROUP BY Zone, Month;

-- 4. Average cost per zone
SELECT 
    Zone,
    AVG(EnergyConsumed_kWh * TariffRate) AS Avg_Cost
FROM smart_city_energy
GROUP BY Zone;

-- 5. Meters with highest faults or outages
SELECT 
    MeterID,
    COUNT(*) AS Fault_Count,
    SUM(OutageMinutes) AS Total_Outage
FROM smart_city_energy
WHERE MeterStatus = 'Faulty' OR OutageMinutes > 0
GROUP BY MeterID
ORDER BY Fault_Count DESC
LIMIT 10;

-- 6. Zones with lowest energy efficiency
SELECT 
    Zone,
    AVG(EnergyConsumed_kWh) AS Avg_Energy,
    AVG(OutageMinutes) AS Avg_Outage
FROM smart_city_energy
GROUP BY Zone
ORDER BY Avg_Energy DESC, Avg_Outage DESC;

-- 7. Weekday vs Weekend peak usage
SELECT 
    CASE 
        WHEN DAYOFWEEK(Date) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    AVG(PeakUsage_kWh) AS Avg_Peak
FROM smart_city_energy
GROUP BY Day_Type;
