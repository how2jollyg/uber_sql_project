---First let's create a surrogate key on the table for creating a table with duplicates
CREATE OR REPLACE TABLE `uber-data1.dev_uber.duplicated-table` AS 
SELECT 
*,
CONCAT(VendorID,tpep_pickup_datetime) AS surrogate_key
FROM `uber-data1.dev_uber.raw_table`;



CREATE OR REPLACE TABLE `uber-data1.dev_uber.analytics-table` AS 
WITH cte AS (
    SELECT 
    surrogate_key, 
    MAX(surrogate_key) AS max_surrogate_key,
    COUNT(*) AS duplicate_count
    FROM `uber-data1.dev_uber.duplicated-table`
    GROUP BY surrogate_key
    HAVING COUNT(*) > 1
)
----As longer as the surrogate key is the only element in double let's keep only the first element of the list---
SELECT DISTINCT * 
FROM cte;

--SELECT *
--FROM cte t
--INNER JOIN cte s
--ON t.surrogate_key = s.surrogate_key
--WHERE t.surrogate_key > s.min_surrogate_key;



