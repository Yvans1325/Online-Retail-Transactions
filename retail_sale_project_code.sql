---  RETAIL TRANSACTIONAL DATA ---
-- This dataset represents retail transactional data. It has been downloaded on Kaggle (a platform that allows data analyst to get some public dataset to pratice).
-- This dataset will be used for analysis purposes. A dashboard will be created on PowerBI for more details.

-- Detailed plan of the pratice --

-- 1. Desciption of the dataset 
-- 2. Data Cleaning
-- 3. Data Exploration
-- 4. Final Dataset Extraction  

                                  --- 1. DESCRIPTION OF THE DATASET ---

-- Let's import the flat file (csv) into SQL developer
-- The csv file contains 302,010 rows. After importing into SQL, 302,010 rows has been counted into it. Great
-- To check, we query :

 Select * 
 From   retail_data_project;
 
 -- Let's see some details about the dataset
 
 Desc retail_data_project;
 
 Info retail_data_project;
 
 Select min(transaction_date), max(transaction_date)
 From retail_data_project;
 
 Select distinct country
 From retail_sale;
 
 -- We get all details about data type, number of rows, null or not null constraints, and so one
 
 --Rows : 302,010
 --Columns : 30
 -- Type : many (number, vachar, date, etc.)
 -- Data are collected from March 2023 to February 2024 (One year) on 5 countries (UK, GERMANY, USA, CANADA, AUSTRALIA)
 
-                                     --- 2. DATA CLEANING ---
 
 -- Let's starting data cleaning process
 
 -- 2.1 Removing data duplicate, if any
 -- 2.2 Standardizing data for any column
 -- 2.3 Handling with null data
 -- 2.4 Removing columns or rows not necessary

             --- 2.1 Removing data duplicate, if any ---
 
 -- Let's have a copy of our dataset to make sure we always have our original version for any checking
 
 Create table retail_sale as 
 Select * 
 From   retail_data_project;
 
 -- Let's check our copy dataset
 Select * 
 From   retail_sale;
 
 -- Now, let's check any duplicate
 -- We don't have details about constraints in the dataset like primary key, unique , check, not null etc.
 -- Based on our understanding, we suppose that transaction_id is the primary key for this table. A transcation can have only one customer but a customer can have many transactions.
 
 -- Let's see if there is any duplicate rows. If we had the primary key, we will use this query to detect any duplicate on the column with the constraint primary key
 
 --First way

 Select transaction_id, count(*)
 From retail_sale
 group by transaction_id
 Having count(*) >1;
 
 -- But this dataset contains many duplicate data in different part like customer name, customer_id, phone_number,email, address,city, country etc
 -- So, let's base on these observations to remove duplicate. 
 -- The ROWID is a unique number attributed to each row on the table by SQL developper. So, let's use this key word to remove duplicate.
 
 -- Second way
 -- let's use rowid key word 
 Select transaction_id, customer_id, name, phone, email,address 
 From retail_sale 
 Where rowid not in (
                      Select Min(rowid)
                      From retail_sale
                      Group by transaction_id);
 -- Now let's delete
 Delete From retail_sale
 Where rowid not in  (
                      Select Min(rowid)
                      From retail_sale
                      Group by transaction_id);
                      
-- 7,548 rows deleted

 -- After deletion, let's notice that some customers have the same id but different name,phone_number, email, address, city and country etc in the table. It could be an error while attributing the id_number, we won't delete this data because it's a huge amount of rows. This error can be fixed by modifying the SEQUENCE created based on the column customer_id 
 -- let's check
 Select r.transaction_id, r.customer_id,r.name,r.phone,r.email,r.address, count(*)
 From retail_sale r join retail_sale s
 on r.customer_id = s.customer_id
 and r.name <> s.name
 and r.phone <> s.phone
 and r.email <> s.email
 and r.address <> s.address
 group by r.transaction_id, r.customer_id,r.name,r.phone,r.email,r.address
 Having count(*)>1;

 Select * 
 From retail_sale 
 Where customer_id = 64722;
 
 Select * 
 From retail_sale 
 Where customer_id = 87729;
 
 -- Let's check the customer_id
 Select distinct customer_id
 From retail_sale;
 
 -- Only 86,560 rows are distinct
 
 -- Let's categorize
 
With test1 as (Select count(*) cnt1
 From retail_sale
 group by customer_id)
 select count(cnt1)
 from test1
 where cnt1<=1;
 
 -- 11,534 customer_id are unique (not duplicate)
 
 With test2 as (Select count(*) cnt2
 From retail_sale
 group by customer_id)
 select count(cnt2)
 from test2
 where cnt2>1;
 
 -- 75,318 customer_id duplicate once or more, representing 282,928 rows.
 -- In summary : 
  -- 86,852 distinct customer_id ( 11,534 unique, 75,318 duplicate)
 
 
-- Removing duplicate done
 
                --- 2.2 Standardizing data for any column ---
-- Let's take a look on each column   
-- Transaction_id
 Select transaction_id, length (transaction_id) l_trans
 From retail_sale;

 With trans_test as
(Select transaction_id, length (transaction_id) l_trans
 From retail_sale)
Select transaction_id 
 From trans_test
 Where l_trans<>7 ;
 
 --Customer_id
 Select customer_id, length (customer_id) l_cust
 From retail_sale;
 
 Select distinct customer_id
 From retail_sale;
 -- Two different numbers but let's continue the process without any changes for this column. Of course, some customer_id are the same but the name, phone, email, address, city, country etc are different.
 
 With cust_test as
(Select customer_id, length (customer_id) l_cust
 From retail_sale)
Select customer_id 
 From cust_test
 Where l_cust<>5;

 -- Name
Select name
From retail_sale; 
--looks good

-- Email
Select email
From retail_sale; 
-- Looks good

-- Phone
Select phone
From retail_sale;
--Looks good
 
 -- Address
Select address
From retail_sale;
--Looks good

-- City
Select city
From retail_sale;

Select city, count(*) c
From retail_sale
Group by city
order by c desc;
--Looks good
 
 -- State
Select state
From retail_sale;
-- Looks good

-- Zipcode
Select zipcode
From retail_sale;
-- Looks good

 -- Country
Select distinct country
From retail_sale
order by country nulls last;
-- Looks good

 -- Age
Select distinct age
From retail_sale
order by age nulls last;
-- Looks good

-- Gender
Select distinct gender
From retail_sale;
-- Looks good

 -- Income
Select distinct income
From retail_sale;
-- Looks good

-- Customer_segment
Select distinct customer_segment
From retail_sale;
-- Looks good

-- Transaction_date
Select transaction_date
From retail_sale;
-- Looks good

-- Total_purchases
Select distinct total_purchases
From retail_sale
order by total_purchases;
-- Looks good

-- Product_category
Select distinct product_category
From retail_sale;
-- Looks good

-- Product_brand
Select distinct product_brand
From retail_sale;
-- Looks good

                      --- 2.3 Handling with null data ---
                      
 Select transaction_id
 From retail_sale
 Where transaction_id is null;
 -- 1 row
 
 Select customer_id
 From retail_sale
 Where customer_id is null;
 -- 293 rows
 
 Select transaction_id, customer_id
 From retail_sale
 Where transaction_id is null and customer_id is null;
 --0 row
 -- To increase the utility of the tabl let's replace the null values. We don't want to remove null data.
 -- Let's replace Null data in transaction_id by the customer_id and vice versa
 
 Select transaction_id, customer_id, nvl(transaction_id, customer_id) n_trans, nvl(customer_id, transaction_id)cn_cust
 from retail_sale
 where transaction_id is null or customer_id is null;
 
 -- Let's update the transaction_id column
 
 Update retail_sale
 set transaction_id = nvl(transaction_id, customer_id)
 Where transaction_id is null;
 
 -- Some key words were missing in the query, let's flashback the table 30minutes before.
 Alter Table retail_sale enable row movement;
 FLASHBACK TABLE retail_sale TO TIMESTAMP sysdate - 30/(24*60);
 
 -- Let's update the customer_id
 
 Update retail_sale
 set customer_id = nvl(customer_id,transaction_id)
 Where customer_id is null;
 
 -- Name
 Select Name
 From retail_sale;
 
 Select *
 From retail_sale
 Where name is null;
 -- 375 rows are null for name
 
 -- Let's extract an alias from the email for these null rows and replace the null value by this alias.
 
 Select name, email, substr(email,1,instr(email,'@')-1) n1
 from retail_sale
 where name is null;
 
 Update retail_sale 
 Set name = substr(email,1,instr(email,'@')-1)
 Where name is null;
 
 -- Email
 Select *
 From retail_sale
 where email is null;
  --338 rows found. We can update this column by sending to these customers a form to fill out via their phone number (sms) or box mail. We cannot delete these rows.
  -- We can do the same for phone number, address, city,state, zipcode and country,gender
  
 -- Phone
 with ver_p as (
 Select phone, length(phone) lph
 From retail_sale)
 Select phone, lph
 From ver_p
 where lph <> 10;
 
 -- Age
 
 Select * 
 From retail_sale
 where age is null;
 -- 171 rows found, representing 0.05%. So, we can use the average to replace null values
 
 -- Let's take a look on the average
 Select round(avg(age))
 From retail_sale;
 -- 36
 
 -- let's take a look on the average by gender
Select gender, round(avg(age))
 From retail_sale
 group by gender;
 -- Male : 35
 -- Female :36
 
 Select age, gender
 From retail_sale
 where age is null and gender is null;
 -- 0 row found
 
 -- Let's see the null for by gender
 Select gender,count(nvl(age,0))
 From retail_sale
 where age is null
 group by gender;
 -- Male : 99
 -- Female: 72
 -- Total : 171 rows
 
 -- Let's update the null value for age by using the average for different gender
 -- Let's update the null value in age column where gender is male by using the average of age for male
 
 Update retail_sale
 Set age = (select round(avg(age)) from retail_sale where gender ='Male')
 where age is null and gender ='Male';
 
 -- Let's update the null value in age column where gender is female by using the average of age for female
 Update retail_sale
 Set age = (select round(avg(age)) from retail_sale where gender ='Female')
 where age is null and gender ='Female';
 
 --Income
 Select income, count(*)
 From retail_sale
 group by income;
 -- Low :94013
 -- High : 73,094
 -- Medium : 127070
 -- Null ; 285 (0.09)%
 
-- So we can replace the null values by the high frecency (Medium) because this is qualitative variable.
 With inc_sel as (
 Select income, count(*) cnt
 From retail_sale
 group by income)
 Select income
 from inc_sel
 where cnt = (select max(cnt)
 from inc_sel);
 
 -- Let's update the null values for income bu using the high frequency for this variable (medium)
 Update retail_sale
 Set income = (With inc_sel as (
               Select income, count(*) cnt
               From retail_sale
               group by income)
                 Select income
                 from inc_sel
                 where cnt = (select max(cnt)
                 from inc_sel))
 where income is null; 
 
 -- Year and Month
 Select year
 From retail_sale
 Where year is null;
  -- 344 rows found
  
Select month
From retail_sale
Where month is null;
--264 rows found

-- Let's update these columns with the transaction_date column

--Let's rename Year and Month columns
Alter table retail_sale 
Rename column " Year_transaction" to Year_transaction; 

Alter table retail_sale 
Rename column " Month_transaction" to Month_transaction;

-- Now, let's update the column Year_transaction
Update retail_sale
Set Year_transaction = nvl(Year_transaction,extract(year from transaction_date))
Where Year_transaction is null;
 
 -- Now, let's update the column Month_transaction
Update retail_sale
Set Month_transaction = nvl(Month_transaction,extract(month from transaction_date))
Where Month_transaction is null;

-- Total_Purchases

Select total_purchases
From retail_sale 
Where total_purchases is null;
 --355 rows found, representing 0.12%. 
 Select round(avg(total_purchases))
 From retail_sale;
 
 --Now, let's replace the null value by the average
 Update retail_sale
 Set total_purchases = (select avg(total_purchases) From retail_sale)
 Where total_purchases is null;

 -- Amount
Select amount
From retail_sale
Where amount is null;
 -- 347 rows found, representing 0.12%

Select total_purchases,round(avg(amount))
From retail_sale
group by total_purchases
order by total_purchases;

 -- Let's update the null value for the Amount column by the average
 
Update retail_sale
Set Amount = (Select avg(amount) from retail_sale)
Where Amount is null;

Update retail_sale
Set Amount = round(amount);

-- Feedback

select feedback from retail_sale
where feedback is null;
 -- 179 rows found, representing 0.06%

Select feedback, count(*) cnf
From retail_sale
group by feedback
order by cnf desc;

With f_db as (
                Select feedback, count(*) cnf
                From retail_sale
                group by feedback
                order by cnf desc)
Select feedback 
From f_db
Where cnf = (select max(cnf) from f_db);

 -- Because Feedback is a qualitative variable, Let's update the feedback column by the high frequency value
 Update retail_sale
 Set Feedback = (With f_db as (
                Select feedback, count(*) cnf
                From retail_sale
                group by feedback
                order by cnf desc)
Select feedback 
From f_db
Where cnf = (select max(cnf) from f_db))
Where feedback is null;

                       --- 2.4 Removing columns or rows not necessary ---

-- No unnecessary columns or rows are observed, some columns might be unused to increase the performance of query.

                                 --- 3. DATA EXPLORATION---
                                 
 -- Let's have general information of the cleaned database
 
 select count(*) Observations,
 min(transaction_date) min_date, 
 max(transaction_date) max_date, 
 sum(Case when gender='Male' then 1 Else 0 End) Male,
 sum(Case when gender='Female' then 1 Else 0 End) Female,
 round(avg(age)) avg_age, 
 sum(total_purchases),
 sum(round (total_amount))
 from retail_sale;
 
 -- CUSTOMER SEGMENTATION--
 
 -- Let's see the total transactions by country
 Select country, count(*) cntc
 From retail_sale
 Where country is not null
 group by country
 Order by cntc desc;
 
  -- Let's the total transaction by gender and country
 Select country,gender, count(*) cng
 From retail_sale
 where gender is not null and country is not null
 group by country,gender
 Order by country, cng desc;
 
 -- Customer_segment distribution
 Select customer_segment, count(*) cnt
 From retail_sale
 Where customer_segment is not null
 Group by customer_segment
 Order by cnt desc;

 -- Customer Income Distribution
 Select income, count(*) cnt
 From retail_sale
 Where income is not null
 Group by income
 Order by cnt desc;
 
 -- Distribution revenue by customer_segment and country
 Select country,customer_segment,sum(amount*total_purchases) as Revenue,
 row_number() over (Partition by Country order by sum(amount*total_purchases) desc) row_num
 From retail_sale
 Where customer_segment is not null and country is not null
 Group by country,customer_segment;
 
 -- Distribution revenue by income and country
 Select country,income,sum(amount*total_purchases) as Revenue,
 row_number() over (Partition by Country order by sum(amount*total_purchases) desc) row_num
 From retail_sale
 Where income is not null and country is not null
 Group by country,income;
 
 -- Top 50 customers by country with the higher value of total_amount
 with key_customer as (
 Select country,name,city, phone, email, address, zipcode, state, total_amount,total_purchases,count(*) cnt,
 row_number() over (Partition by country order by total_amount desc) row_num
 From retail_sale
 Group by country,name,city, phone, email, address, zipcode, state, total_amount, total_purchases)
 Select country,name,phone,email, address ||','||city||','||country||','||zipcode as address_cust,total_amount 
 From key_customer
 where row_num<=50;
 
 -- SALES PERFORMANCE ANALYSIS
 -- Revenue Trend Analysis
 -- Let's see the total transaction, total purchases and revenue trend by country
 With rolling_sum as (
 Select country, count(*) as Total_transaction,
 sum(total_purchases) as Total_purchases_t, 
 sum(amount*total_purchases) as Revenue
 From retail_sale
 Where country is not null
 group by country
 order by revenue desc)
 Select country, Total_transaction, Total_purchases_t,revenue, 
 sum(revenue) over (order by revenue desc) rolling_sum
 From rolling_sum;
 
  -- Let's see the total transaction, total purchases and revenue trend by gender
 With rolling_sum as (
 Select gender, count(*) as Total_transaction,
 sum(total_purchases) as Total_purchases_t, 
 sum(amount*total_purchases) as Revenue
 From retail_sale
 Where gender is not null
 group by gender
 order by revenue desc)
 Select gender, Total_transaction, Total_purchases_t,revenue, 
 sum(revenue) over (order by revenue desc) rolling_sum
 From rolling_sum;
 
 -- Let's the total transaction, total purchases and revenue trend by group age
 With gr_db as
 (Select transaction_id, age, total_purchases, amount,
 Case 
 When age < 35 Then '<35 years old'
 When age >= 35 and age <55 Then '35-55 years old'
 Else '>55 years old'
 End Group_age
 from retail_sale),
 gp_tt as (
 Select group_age, count(*) Transactions, 
 sum(total_purchases) Total_purchases_t, 
 sum(total_purchases*amount) Revenue
 from gr_db
 group by group_age 
 order by revenue desc)
 Select group_age, transactions, total_purchases_t,revenue,
 sum(revenue) over (order by revenue) rolling_sum
 from gp_tt
 order by revenue desc;
 
-- Let's see now the total of transactions, total of purchases and revenue trend over month and week

-- Over month
select to_char(transaction_date,'Mon-YY') Month_t,
count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue
From retail_sale
group by to_char(transaction_date,'Mon-YY')
order by revenue desc;

-- Over Week
Select to_char(transaction_date,'Day') Week_day,
count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue
From retail_sale
where transaction_date is not null
group by to_char(transaction_date,'Day')
order by revenue desc;

 -- Product Analysis (Identify Peak sales)
 -- Let's take a look on the product_brand
 -- Two ways to determnine the top three of product_brand with the highest revenue by country
 -- First way
Select country, product_brand, transactions,total_purchases_t,revenue, row_num
from (Select country, product_brand,count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) revenue,
row_number() over (Partition by country order by sum(total_purchases*amount) desc) as row_num
From retail_sale
Where country is not null and product_brand is not null
group by country, product_brand)
Where row_num <=3;

 -- Second way
With pb as (
Select country, product_brand,count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue,
row_number() over (Partition by country order by sum(total_purchases*amount) desc) as row_num
From retail_sale
Where country is not null and product_brand is not null
group by country, product_brand)
Select country, product_brand, transactions,total_purchases_t,Revenue, row_num
from pb
Where row_num <=3;

-- Top 20 highest revenue product_brand over past year
With pb as (
Select country, product_brand,count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue,
row_number() over (order by sum(total_purchases*amount) desc) as row_num
From retail_sale
Where country is not null and product_brand is not null
group by country, product_brand)
Select country, product_brand, transactions,total_purchases_t,Revenue, row_num
from pb
Where row_num <=20;
 -- The first 15 are located in the USA
 
 -- Now, let's see the type of product by product-brand in each country
 
Select country, product_brand, count(*) as Transactions, listagg(distinct product_type,' : ') within group (order by product_type desc) as type_pr
from retail_sale
group by country, product_brand 
order by country,Transactions desc;

-- 20 top-selling product_type over past year
With pt as (
Select product_type,count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue,
row_number() over (order by sum(total_purchases*amount) desc) as row_num
From retail_sale
Where product_type is not null
group by product_type)
Select product_type,transactions,total_purchases_t,Revenue, row_num
from pt
Where row_num <=20;

-- 20 top-selling product_category over past year
With pc as (
Select product_category,count(*) Transactions, 
sum(total_purchases) Total_purchases_t, 
sum(total_purchases*amount) Revenue,
row_number() over (order by sum(total_purchases*amount) desc) as row_num
From retail_sale
Where product_category is not null
group by product_category)
Select product_category,transactions,total_purchases_t,Revenue, row_num
from pc
Where row_num <=20;

 -- Total purchases by country
select country,sum(total_purchases) smt
from retail_sale
where country is not null
group by country
order by smt desc;

--Payment method by customer

Select payment_method, count(*) cnt
From retail_sale
where payment_method is not null
Group by payment_method
Order by cnt desc;

 -- CUSTOMER SATISFACTION
 -- Average of Customer rating
 
 Select country, avg(ratings),round(avg(ratings),3) avg_rating
 From retail_sale
 Where country is not null
 Group by country
 Order by avg_rating desc;
 
-- Let's see the feedback
Select country,feedback,count(feedback) cnf
from retail_sale
where country is not null
group by country, feedback
order by country, cnf desc;
