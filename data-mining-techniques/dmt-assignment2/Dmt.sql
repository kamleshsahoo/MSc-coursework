# CREATE DATABASE DMT;
USE DMT;
-- SHOW VARIABLES LIKE "secure_file_priv";
-- SHOW PROCESSLIST;
-- KILL 18;
-- DROP TABLE Testsearch;
-- DROP TABLE TrainSearch;
-- DROP TABLE Propfactors;
-- DROP TABLE Propfactors3M;


CREATE TABLE TrainSearch (
    srch_id BIGINT,
    date_time DATETIME,
    site_id BIGINT,
    visitor_location_country_id BIGINT,
    visitor_hist_starrating DOUBLE,
    visitor_hist_adr_usd DOUBLE,
    prop_country_id BIGINT,
    prop_id BIGINT,
    prop_starrating BIGINT,
    prop_review_score DOUBLE,
    prop_brand_bool BIGINT,
    prop_location_score1 DOUBLE,
    prop_location_score2 DOUBLE,
    prop_log_historical_price DOUBLE,
    position BIGINT,
    price_usd DOUBLE,
    promotion_flag BIGINT,
    srch_destination_id BIGINT,
    srch_length_of_stay BIGINT,
    srch_booking_window BIGINT,
    srch_adults_count BIGINT,
    srch_children_count BIGINT,
    srch_room_count BIGINT,
    srch_saturday_night_bool BIGINT,
    srch_query_affinity_score DOUBLE,
    orig_destination_distance DOUBLE,
    random_bool BIGINT,
    comp1_rate DOUBLE,
    comp1_inv DOUBLE,
    comp1_rate_percent_diff DOUBLE,
    comp2_rate DOUBLE,
    comp2_inv DOUBLE,
    comp2_rate_percent_diff DOUBLE,
    comp3_rate DOUBLE,
    comp3_inv DOUBLE,
    comp3_rate_percent_diff DOUBLE,
    comp4_rate DOUBLE,
    comp4_inv DOUBLE,
    comp4_rate_percent_diff DOUBLE,
    comp5_rate DOUBLE,
    comp5_inv DOUBLE,
    comp5_rate_percent_diff DOUBLE,
    comp6_rate DOUBLE,
    comp6_inv DOUBLE,
    comp6_rate_percent_diff DOUBLE,
    comp7_rate DOUBLE,
    comp7_inv DOUBLE,
    comp7_rate_percent_diff DOUBLE,
    comp8_rate DOUBLE,
    comp8_inv DOUBLE,
    comp8_rate_percent_diff DOUBLE,
    click_bool BIGINT,
    gross_bookings_usd DOUBLE,
    booking_bool BIGINT
    );

CREATE TABLE TestSearch
LIKE TrainSearch;

ALTER TABLE TestSearch 
DROP COLUMN position; 
ALTER TABLE TestSearch 
DROP COLUMN gross_bookings_usd;
ALTER TABLE TestSearch 
DROP COLUMN click_bool; 
ALTER TABLE TestSearch 
DROP COLUMN booking_bool;

-- SHOW GLOBAL VARIABLES LIKE 'local_infile';

-- SET GLOBAL innodb_buffer_pool_size=268435456;
-- SET GLOBAL innodb_buffer_pool_size=1073741824;
-- SHOW GLOBAL VARIABLES LIKE 'innodb_buffer_pool_size';
-- show engine innodb status;

-- SET GLOBAL local_infile = true;

-- SELECT count(*) FROM testsearch;
-- SELECT count(*) FROM trainsearch;

-- May need to change PATH to train.csv:
LOAD DATA LOCAL INFILE 'C:\\Users\\Kamlesh\\dir1\\DMT2021\\training_set_VU_DM.csv' 
INTO TABLE TrainSearch 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

-- May need to change PATH to test.csv:
LOAD DATA LOCAL INFILE 'C:\\Users\\Kamlesh\\dir1\\DMT2021\\test_set_VU_DM.csv' 
INTO TABLE TestSearch
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

-- Warning: The following 2 commands took ~1 hr each on my laptop.
ALTER TABLE TrainSearch 
ADD COLUMN row_num BIGINT AUTO_INCREMENT PRIMARY KEY FIRST;

-- SELECT * FROM Trainsearch WHERE row_num>=1 and row_num<=2;
-- SELECT MAX(row_num) FROM Trainsearch;
-- SELECT * FROM Trainsearch WHERE row_num >= 3499705 and row_num <= 3499720;
 -- SELECT * FROM Trainsearch WHERE row_num >= 3966665 and row_num <= 3966675;
-- SELECT * FROM Trainsearch WHERE row_num >= 4499605 and row_num <= 4499640;

-- SELECT MAX(row_num) FROM testsearch;

-- SELECT * FROM TESTSEARCH WHERE ROW_NUM = '4959183';

ALTER TABLE TestSearch
ADD COLUMN row_num BIGINT AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE TABLE PropFactors (     
       prop_id BIGINT PRIMARY KEY,
       prop_cnt BIGINT,
       train_price_avg DOUBLE,
       click_cnt BIGINT,
       booking_cnt BIGINT,
       promotion_cnt BIGINT
       );


INSERT INTO PropFactors 
SELECT prop_id,  
       Count(prop_id) AS prop_cnt, 
       Avg(price_usd) AS train_price_avg, 
       Sum(click_bool) AS click_cnt, 
       Sum(booking_bool) AS booking_cnt, 
       Sum(promotion_flag) AS promotion_cnt 
FROM TrainSearch 
GROUP BY prop_id;

CREATE TABLE PropFactors4M
LIKE PropFactors;

CREATE TABLE PropFactors1M
LIKE PropFactors;

INSERT INTO PropFactors4M 
SELECT prop_id,  
       Count(prop_id) AS prop_cnt, 
       Avg(price_usd) AS train_price_avg, 
       Sum(click_bool) AS click_cnt, 
       Sum(booking_bool) AS booking_cnt, 
       Sum(promotion_flag) AS promotion_cnt 
FROM TrainSearch 
WHERE row_num <= 3966671
GROUP BY prop_id;

INSERT INTO PropFactors1M 
SELECT prop_id,  
       Count(prop_id) AS prop_cnt, 
       Avg(price_usd) AS train_price_avg, 
       Sum(click_bool) AS click_cnt, 
       Sum(booking_bool) AS booking_cnt, 
       Sum(promotion_flag) AS promotion_cnt 
FROM TrainSearch 
WHERE row_num >= 3966672
GROUP BY prop_id;

-- SELECT * FROM PropFactors WHERE prop_id = 78242;

-- SELECT * FROM PropFactors WHERE prop_id=893;
-- SELECT * FROM PROPFACTORS3M;
-- Train on subset of data that doesn't contribute to property counts/avgs.
-- i.e. use counts from first 7M results with remaining ~3M as model trainer. 
-- INSERT INTO PropFactors3M 
-- SELECT prop_id,  
--        Count(prop_id) AS prop_cnt, 
--        Avg(price_usd) AS train_price_avg, 
--        Sum(click_bool) AS click_cnt, 
--        Sum(booking_bool) AS booking_cnt, 
--        Sum(promotion_flag) AS promotion_cnt 
-- FROM TrainSearch 
-- WHERE row_num <= 3499708
-- GROUP BY prop_id;

-- CREATE TABLE PropFactors3M
-- LIKE PropFactors;

-- SELECT * FROM PropFactors3M LIMIT 0, 5 ; 
-- SELECT prop_id,  
--        Count(prop_id) AS prop_cnt, 
--        Avg(price_usd) AS train_price_avg, 
--        Sum(click_bool) AS click_cnt, 
--        Sum(booking_bool) AS booking_cnt, 
--        Sum(promotion_flag) AS promotion_cnt 
-- FROM TrainSearch;

