CREATE OR REPLACE TABLE `uber-data1.dev_uber.fact-table` (

    SELECT 
    trip_id AS STRING, 
    vendor_id AS STRING, 
    passenger_count AS STRING, 
    trip_distance_id AS STRING, 
    rate_code_id AS STRING, 
    store_and_fwd_flag AS STRING, 
    pickup_location_id AS STRING, 
    dropoff_location_id AS STRING,
    payment_type_id AS STRING, 
    fare_amount AS STRING, 
    extra AS STRING, 
    mta_tax AS STRING, 
    tip_amount AS STRING, 
    tolls_amount AS STRING, 
    improvement_surcharge AS STRING, 
    total_amount AS STRING

    FROM `uber-data1.dev_uber.raw_table`

); 

CREATE OR REPLACE TABLE `uber-data1.dev_uber.passenger_count_dim` (
    passenger_count_id STRING, 
    passenger_count STRING

);

CREATE OR REPLACE TABLE `uber-data1.dev_uber.trip_distance_dim` (

    trip_distance_id STRING,
    trip_distance STRING 

);


CREATE OR REPLACE TABLE `uber-data1.dev_uber.rate_code_dim` (

    rate_code_id INT64,
    RatecodeID INT64,
    rate_code_name STRING

);


CREATE OR REPLACE TABLE `uber-data1.dev_uber.payment_type_dim` (

    payment_type_id STRING,
    payment_type STRING,
    payment_type_name STRING

);


CREATE OR REPLACE TABLE `uber-data1.dev_uber.datetime_dim` (

    datetime_id STRING,
    tpep_pickup_datetime STRING,
    pick_hour STRING,
    pick_day STRING,
    pick_month STRING,
    pick_year STRING,
    pick_weekday STRING, 
    tpep_dropoff_datetime STRING, 
    drop_hour STRING, 
    drop_day STRING, 
    drop_month STRING, 
    drop_year STRING, 
    drop_weekday STRING 

);


CREATE OR REPLACE TABLE `uber-data1.dev_uber.pickup_location_dim` (

    pickup_location_id STRING, 
    pickup_latitude STRING, 
    pickup_longitude STRING 

);


CREATE OR REPLACE TABLE `uber-data1.dev_uber.dropoff_location_dim` (

    dropoff_location_id STRING, 
    dropoff_latitude STRING, 
    dropoff_longitude STRING
);

