---Creating a surrogate key for querying multiple columns--- 
---the more unique is your key the better it is. Imagine you would like to create a unique identifier by combining the vendor_id, trip_id and dropoff_pickup_time. 
---You could use this key for checking for duplicates or joining with other tables in a next model conception. Choices are endless 

SELECT 
    vendor_id, 
    trip_id, 
    dropoff_pickup_time, 
    SAFE_CAST(CONCAT(vendor_id,trip_id,dropoff_pickup_time) AS STRING) AS surrogate_trip_key 
FROM `uber-data1.dev_uber.tbl_analytics`
ORDER BY dropoff_pickup_time ASC 

----Working with dates functions---- 
---Often you will have to create a date table in your data model by breaking down the initial timestamp you get from the raw---
---Let`s take back our query from the first create table statement and had our time string converted into a time format---

CREATE OR REPLACE TABLE `uber-data1.dev_uber.datetime_dim` AS
    
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
        `uber-data1.dev_uber.raw_table`
;


----Deduping a table---- 
----This one would be a great help for deduping table and monitor your data quality over the tables you are updating and querying---

SELECT *
FROM (
  SELECT
      *,
      ROW_NUMBER()
          OVER (PARTITION BY trip_id) as row_number
  FROM `uber-data1.dev_uber.tbl_analytics`
)
WHERE row_number = 1

----OR----

---Comparing the number of distinct rows

SELECT COUNT(1)
FROM (SELECT DISTINCT * 
			FROM `uber-data1.dev_uber.tbl_analytics`) as distinct_rows,
SELECT COUNT(1) 
FROM (SELECT *
			FROM `uber-data1.dev_uber.tbl_analytics`) as total_rows

----deduping the table---
---What you need there after performing these two steps is to select the rows that are unique outside the table containing the total rows---
---Let's do it with a CTE instead of creating a new table and checking for duplicates on one column---
----In this case trip_id is the grouping criteria. Be aware that regarding your case if you don't have a unique key, you better cast before different columns for creating a surrogate key and grouping by this one---

WITH cte AS (
    SELECT 
    trip_id, min(trip_id) as min_trip_id
    FROM `uber-data1.dev_uber.tbl_analytics`
    GROUP BY trip_id
    HAVING COUNT(*) > 1
)

---creating a new table--- 
CREATE TABLE `uber-data1.dev_uber.tbl_new_analytics` AS 
SELECT *
FROM `uber-data1.dev_uber.tbl_analytics` ana
INNER JOIN cte 
ON ana.trip_id = cte.trip_id
WHERE ana.trip_id > cte.min_trip_id 

DROP TABLE `uber-data1.dev_uber.tbl_analytics`

RENAME TABLE `uber-data1.dev_uber.tbl_new_analytics` TO `uber-data1.dev_uber.tbl_analytics`

----Working with multiple CTEs----

