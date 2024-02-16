
CREATE OR REPLACE TABLE `uber-data1.demo_uber.passenger_count_dim` AS 
    SELECT
        ROW_NUMBER() OVER () AS passenger_count_id,
        passenger_count,
    FROM 
        `uber-data1.demo_uber.raw_table`; 


CREATE OR REPLACE TABLE `uber-data1.demo_uber.trip_distance_dim` AS
    SELECT
        ROW_NUMBER() OVER () AS trip_distance_id,
        trip_distance,
    FROM 
        `uber-data1.demo_uber.raw_table`
;

CREATE OR REPLACE TABLE `uber-data1.demo_uber.rate_code_dim` AS

    SELECT 
        CAST(ROW_NUMBER() OVER () AS STRING) AS rate_code_id,
        RatecodeID,
        rate_code_name
    FROM `uber-data1.demo_uber.rate_code_dim`
;


---Trouver une alternative à cette subquery---
INSERT INTO `uber-data1.demo_uber.rate_code_dim` (RatecodeID,rate_code_name)
VALUES (1,'Standard rate'),
      (2,'JFK'),
      (3,'Newark'),
      (4,'Nassau or Wetchester'),
      (5,'Negociated fare'),
      (6,'Group ride');

CREATE OR REPLACE TABLE `uber-data1.demo_uber.rate_code_dim` AS
    SELECT
        ROW_NUMBER() OVER() AS rate_code_id,
        RatecodeID,
        rate_code_name
    FROM 
      `uber-data1.demo_uber.rate_code_dim`

;

INSERT INTO `uber-data1.demo_uber.payment_type_dim` (payment_type,payment_type_name)
VALUES (1,'Credit card'),
      (2,'Cash'),
      (3,'No charge'),
      (4,'Dispute'),
      (5,'Unknown'),
      (6,'Voided trip');


CREATE OR REPLACE TABLE `uber-data1.demo_uber.payment_type_dim` AS

    SELECT
        CAST(ROW_NUMBER() OVER() AS STRING)  AS payment_type_id,
        payment_type,
        payment_type_name 
    FROM
        `uber-data1.demo_uber.payment_type_dim`
;


CREATE OR REPLACE TABLE `uber-data1.demo_uber.datetime_dim` AS
    
    SELECT
        ROW_NUMBER() OVER() AS datetime_id,
        tpep_pickup_datetime,
        EXTRACT(HOUR FROM tpep_pickup_datetime) AS pick_hour,
        EXTRACT(DAY FROM tpep_pickup_datetime) AS pick_day,
        EXTRACT(MONTH FROM tpep_pickup_datetime) AS pick_month,
        EXTRACT(YEAR FROM tpep_pickup_datetime) AS pick_year,
        EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS pick_weekday,
        tpep_dropoff_datetime,
        EXTRACT(HOUR FROM tpep_dropoff_datetime) AS drop_hour,
        EXTRACT(DAY FROM tpep_dropoff_datetime) AS drop_day,
        EXTRACT(MONTH FROM tpep_dropoff_datetime) AS drop_month,
        EXTRACT(YEAR FROM tpep_dropoff_datetime) AS drop_year,
        EXTRACT(DAYOFWEEK FROM tpep_dropoff_datetime) AS drop_weekday
    FROM 
        `uber-data1.demo_uber.raw_table`
;


CREATE OR REPLACE TABLE `uber-data1.demo_uber.pickup_location_dim` AS
    SELECT
        ROW_NUMBER() OVER() AS pickup_location_id,
        pickup_latitude, 
        pickup_longitude 
    FROM 
        `uber-data1.demo_uber.raw_table`
;


CREATE OR REPLACE TABLE `uber-data1.demo_uber.dropoff_location_dim` AS
    SELECT
        ROW_NUMBER() OVER() AS dropoff_location_id, 
        dropoff_latitude, 
        dropoff_longitude,
    FROM 
        `uber-data1.demo_uber.raw_table`    

;

CREATE OR REPLACE TABLE `uber-data1.demo_uber.fact-table` AS
    SELECT 
      ROW_NUMBER() OVER() AS trip_id, 
      VendorID AS vendor_id, 
      passenger_count, 
      fare_amount, 
      extra, 
      mta_tax, 
      tip_amount, 
      tolls_amount, 
      improvement_surcharge, 
      total_amount
    FROM
    `uber-data1.demo_uber.fact-table` 
