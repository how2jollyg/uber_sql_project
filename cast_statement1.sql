CREATE OR REPLACE TABLE uber-data1.demo_uber.passenger_count_dim AS 
SELECT 
  CAST(passenger_count_id AS STRING) AS passenger_count_id,
  passenger_count
FROM uber-data1.demo_uber.passenger_count_dim;

CREATE OR REPLACE TABLE uber-data1.demo_uber.pickup_location_dim AS 
SELECT 
  CAST(pickup_location_id AS STRING) AS pickup_location_id,
  pickup_latitude,
  pickup_longitude
FROM uber-data1.demo_uber.pickup_location_dim;

CREATE OR REPLACE TABLE uber-data1.demo_uber.dropoff_location_dim AS 
SELECT 
  CAST(dropoff_location_id AS STRING) AS dropoff_location_id,
  dropoff_latitude,
  dropoff_longitude
FROM uber-data1.demo_uber.dropoff_location_dim;

CREATE OR REPLACE TABLE uber-data1.demo_uber.rate_code_dim AS 
SELECT 
  CAST(rate_code_id AS STRING) AS rate_code_id,
  RatecodeID,
  rate_code_name
FROM uber-data1.demo_uber.rate_code_dim;

CREATE OR REPLACE TABLE uber-data1.demo_uber.trip_distance_dim AS 
SELECT 
  CAST(trip_distance_id AS STRING) AS trip_distance_id,
  trip_distance
FROM uber-data1.demo_uber.trip_distance_dim;

CREATE OR REPLACE TABLE uber-data1.demo_uber.datetime_dim AS 
SELECT 
  CAST(datetime_id AS STRING) AS datetime_id,
  tpep_pickup_datetime,
  pick_hour,
  pick_day,
  pick_month,
  pick_year,
  pick_weekday,
  tpep_dropoff_datetime,
  drop_hour,
  drop_day,
  drop_month,
  drop_year,
  drop_weekday
FROM uber-data1.demo_uber.datetime_dim;



