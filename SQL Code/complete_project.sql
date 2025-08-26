-- Create gold folder in the workshop catalog
CREATE FOLDER catalog.workshop.gold;

-- Create raw copies of the sample weather datasets in the bronze-layer
CREATE VIEW catalog.workshop.bronze.nyc_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."NYC-weather.csv";
CREATE VIEW catalog.workshop.bronze.sf_weather_raw AS SELECT * FROM Samples."samples.dremio.com"."SF weather 2018-2019.csv";

-- Create silver-layer weather View with cleaned attribute names and data types
CREATE VIEW catalog.workshop.silver.nyc_weather AS SELECT 
        station,
        location_name,
        TO_DATE(calendar_date, 'YYYY-MM-DD', 1) AS calendar_date,
        average_wind,
        precipitation,
        snow,
        snow_depth,
        temp_max,
        temp_min
FROM   (SELECT 
                station,
                name AS location_name,
                CASE WHEN LENGTH(SUBSTR(nyc_weather."date", 1, 10)) > 0 THEN SUBSTR(nyc_weather."date", 1, 10) ELSE NULL END AS calendar_date,
                CASE WHEN nyc_weather."awnd" != '' THEN CAST(nyc_weather."awnd" AS FLOAT) ELSE NULL END AS average_wind,
                CAST(nyc_weather."prcp" AS FLOAT) AS precipitation,
                CAST(nyc_weather."snow" AS FLOAT) AS snow,
                CAST(nyc_weather."snwd" AS FLOAT) AS snow_depth,
                CAST(nyc_weather."tempmax" AS FLOAT) AS temp_max,
                CAST(nyc_weather."tempmin" AS FLOAT) AS temp_min
        FROM   catalog.workshop.bronze.nyc_weather_raw AS nyc_weather
) nested_0;

-- Create gold-layer trips View enriched with weather data
CREATE VIEW catalog.workshop.gold.trips_enriched AS SELECT 
    location_name,
    pickup_date,
    pickup_time,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    average_wind,
    precipitation,
    snow,
    snow_depth,
    temp_max,
    temp_min
FROM 
    catalog.workshop.silver.trips as t INNER JOIN catalog.workshop.silver.nyc_weather as w ON t.pickup_date = w.calendar_date
    LIMIT 30000000;
