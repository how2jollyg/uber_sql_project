---Founding the highest values per payment type and vendor_id (top performing vendors per payment type)--- 

WITH ROWCTE (ROWNO) AS
    (SELECT
        ROW_NUMBER() OVER(PARTITION BY payment_type ORDER BY vendor_id) AS ROWNO
    FROM `uber-data1.dev_uber.tbl_analytics`
    )

SELECT payment_type_name, ROWNO FROM ROWCTE

---Founding the highest values per payment type and vendor_id (top performing vendors per payment type)--- 
SELECT vendor_id
FROM `uber-data1.dev_uber.tbl_analytics`
GROUP BY payment_type_name 
ORDER BY total_amount DESC
LIMIT 5; 

SELECT vendor_id IN
    (SELECT
        ROW_NUMBER() OVER(PARTITION BY payment_type ORDER BY vendor_id) AS ROWNO
    FROM `uber-data1.dev_uber.tbl_analytics`)

---For each user that has at least taken two rides what is the time that has elapsed between two rides for one passenger---

---How to find the tpep1 and tpep2 ? With a subquery taking the first top two rows of the result 
---Without CTE---
SELECT 
    vendor_id,
    tpep_pickup_datetime,
    LAG(tpep_pickup_datetime,1) OVER(PARTITION BY vendor_id ORDER BY tpep_pickup_datetime DESC) - tpep_pickup_datetime AS time_between_two_trip
FROM `uber-data1.dev_uber.tbl_analytics`
WHERE vendor_id IN  
    (SELECT 
        vendor_id,
    FROM `uber-data1.dev_uber.tbl_analytics`
        GROUP BY vendor_id 
        HAVING COUNT(*) > 1)

---With CTE---
WITH CTE AS
    (SELECT 
        vendor_id,
    FROM `uber-data1.dev_uber.tbl_analytics`
        GROUP BY vendor_id 
        HAVING COUNT(*) > 1)
    
SELECT cte.vendor_id,
    tpep_pickup_datetime,
    LAG(tpep_pickup_datetime,1) OVER(PARTITION BY cte.vendor_id ORDER BY tpep_pickup_datetime DESC) - tpep_pickup_datetime AS time_between_two_trip
FROM `uber-data1.dev_uber.tbl_analytics` ana
LEFT JOIN CTE cte 
ON ana.vendor_id = cte.vendor_id


---Find the latest timestamp for users who took at least one trip--
--A retravailler 
SELECT 
    *
FROM 
(SELECT 
        vendor_id,
    FROM `uber-data1.dev_uber.tbl_analytics`
        GROUP BY vendor_id 
        HAVING COUNT(*) > 0) a 
JOIN 
(SELECT 
    vendor_id,
    tpep_pickup_datetime,
    RANK() OVER(PARTITION BY vendor_id ORDER BY tpep_pickup_datetime DESC)
    FROM `uber-data1.dev_uber.tbl_analytics`) b
ON b.vendor_id = a.vendor_id

SELECT 
    vendor_id,
    MAX(tpep_pickup_datetime) as lastest_datetime
FROM  `uber-data1.dev_uber.tbl_analytics`
GROUP BY vendor_id
ORDER BY vendor_id;

---CASE STATEMENTS
--Case Statements are tipycally used if you are looking case disjunctions in a table---

---Let's suppose you'd like to compute the total fare of the ride and seeing if they are some drivers that are applying different fares than regular ones for regulated fare like Airports---
SELECT 
    CASE WHEN rate_code_name = 'Nassau or Wetchester' THEN 1
    WHEN rate_code_name = 'Newark' THEN 2
    WHEN rate_code_name = 'JFK' THEN 3
    END AS ride_id,
    vendor_id, 
    total_amount,
    r.rate_code_name
---Joining before performing the request---    
FROM `uber-data1.dev_uber.fact-table` f
LEFT JOIN `uber-data1.dev_uber.rate_code_dim` r
ON r.rate_code_id = f.trip_id


