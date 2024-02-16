CREATE OR REPLACE TABLE `uber-data1.demo_uber.fact-table` AS
    SELECT 
      t.trip_id, 
      t.VendorID AS vendor_id, 
      dt.datetime_id,
      pc.passenger_count_id,
      td.trip_distance_id,
      rc.rate_code_id,
      t.store_and_fwd_flag,
      pl.pickup_location_id,
      dl.dropoff_location_id,
      pt.payment_type_id,
      t.fare_amount, 
      t.extra, 
      t.mta_tax, 
      t.tip_amount, 
      t.tolls_amount, 
      t.improvement_surcharge, 
      t.total_amount
    FROM
    `uber-data1.demo_uber.raw_table` t
    LEFT JOIN `uber-data1.demo_uber.passenger_count_dim` pc 
    ON t.trip_id = pc.passenger_count_id
    
    LEFT JOIN `uber-data1.demo_uber.trip_distance_dim` td 
    ON t.trip_id = td.trip_distance_id
    
    LEFT JOIN `uber-data1.demo_uber.rate_code_dim` rc 
    ON t.RatecodeID = rc.RatecodeID
    
    LEFT JOIN `uber-data1.demo_uber.pickup_location_dim` pl 
    ON t.trip_id = pl.pickup_location_id
    
    LEFT JOIN `uber-data1.demo_uber.dropoff_location_dim` dl 
    ON t.trip_id = dl.dropoff_location_id
    
    LEFT JOIN `uber-data1.demo_uber.datetime_dim` dt 
    ON t.trip_id = dt.datetime_id
    
    LEFT JOIN `uber-data1.demo_uber.payment_type_dim` pt 
    ON t.payment_type = pt.payment_type
 