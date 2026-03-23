---Retrieves all data from the Bright Coffee Shop analysis dataset.
select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;

---Retrieves distinct product types from the dataset
select distinct product_type
 from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;

---Retrieves distinct product categories from the dataset
 select distinct product_category
 from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;

---Retrieves distinct store locations from the dataset
select distinct store_location
 from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;

---This query computes total revenue for each product by multiplying transaction quantity by unit price, groups the results by product detail, and sorts them in descending order to highlight the highest revenue-generating products.
 select product_detail,
        sum(transaction_qty * unit_price) as total_revenue
 from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
 group by product_detail
 order by total_revenue desc;

 ---Counts total transactions per store and ranks them from highest to lowest.
 select 
    store_id,
    store_location,
    count(transaction_id) AS total_transactions
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
group by store_id, store_location
order by total_transactions DESC;

---Determines the best-performing time of day for each store by grouping transactions into time periods, calculating total revenue, and ranking the results to identify the highest-performing period per store.
select
        store_id,
        store_location,
        CASE 
            WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 18 AND 21 THEN 'Evening'
            ELSE 'Night'
        END AS time_of_day,
        SUM(transaction_qty * unit_price) AS total_revenue
    from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
    group by store_id, store_location, time_of_day;

---Calculates the total quantity of items sold for each product category by summing transaction quantities and ranking categories by sales volume.
select 
    product_category,
    SUM(transaction_qty) AS total_quantity_sold
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
group by product_category
order by total_quantity_sold DESC;

---Analyzes sales trends by aggregating revenue and quantity across product categories, time-of-day intervals, and store locations to identify patterns in customer purchasing behavior.
select 
    store_location,
    product_category,
    CASE 
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM transaction_time) BETWEEN 18 AND 21 THEN 'Evening'
        ELSE 'Night'
    end AS time_of_day,
    sum(transaction_qty * unit_price) AS total_revenue,
    sum(transaction_qty) AS total_quantity
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
group by store_location,
        product_category,
         time_of_day
order by store_location,
        total_revenue DESC;

