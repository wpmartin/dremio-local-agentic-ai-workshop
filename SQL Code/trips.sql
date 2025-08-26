-- Create silver folder in the workshop catalog
CREATE FOLDER catalog.workshop.silver;

-- Create silver-layer trips View with cleaned attribute names
CREATE VIEW catalog.workshop.silver.trips AS SELECT 
    TO_TIME(pickup_time, 'HH24:MI:SS', 1) AS pickup_time,
    TO_DATE(pickup_date, 'YYYY-MM-DD', 1) AS pickup_date,
    passenger_count,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount
FROM   (SELECT 
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 12, LENGTH(nyc_trips."pickup_datetime") - 15) ELSE NULL END AS pickup_time,
            CASE WHEN LENGTH(SUBSTR(nyc_trips."pickup_datetime", 1, 10)) > 0 THEN SUBSTR(nyc_trips."pickup_datetime", 1, 10) ELSE NULL END AS pickup_date,
            passenger_count,
            trip_distance_mi AS trip_distance,
            fare_amount,
            tip_amount,
            total_amount
        FROM  catalog.workshop.bronze.trips_raw AS nyc_trips
) nested_0;