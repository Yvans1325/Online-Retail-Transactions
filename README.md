# Online Retail Transactional Analysis

### 1. Project Overview
The goal of this project is to analyze online retail transaction data, specifically for uncovering trends, patterns, and actionable insights that can help improve sales strategies, customer satisfaction, and overall business performance.

### 2. Data Collection
#### 2.1 Data Sources
This dataset has been downloaded from the platform Kaggle. It represents retail transational data for 5 countries (USA, UK, CAnada, Australia and Germany) over the past year ( Mar 23 - Fev 24). It also contains information about customers, their purchases, products, and transaction details.

The data includes various attributes :

#### 2.2 Attributes

- **Transaction ID**: Unique identifier for each transaction.

- **Customer ID**: Unique identifier for each customer.

- **Name**: Name of the customer.
- **Email**: Email of the customer.
- **Phone**: Phone number of the customer.
- **Address**: Address of the customer.
- **City**: City where the transaction was made.
- **State**: State where the transaction was made.
- **Zipcode**: Zipcode of the city where the transaction was made.
- **Country**: Country where the transaction was made.
- **Age**: Age of the customer.
- **Gender**: Gender of the customer.
- **Income**: Income of the customer.
- **Customer_Segmentation**: Segmentation of the customer.
- **Transaction_date**: Date of the transaction.
- **Year_transaction**: Year of the transaction.
- **Month_Transaction**: Month of the transaction.
- **Total_purchases**: Number of units purchased.
- **Amount**: Price per unit.
- **Total_Amount**: Total amount spent in the transaction.
- **Product_category**: Category of product
- **Product_brand**: Brand of the product
- **Product_type**: Type of product
- **Feedback**: Feedback of the customer.
- **Shipping_method** : Method of shipping
- **Payment_method**: Method of payment
- **Order_status**: Status of the order
- **Rating**: Customer rating

#### 2.3 Tools
Tools used for this project
1. Excel: Data inspection
2. Oracle SQL Developer: Data cleaning and analysis
3. PowerBI: Creating report

### 3. Data Cleaning/Preparation
In this phase, the following tasks have been done:

1. Removing data duplicate, if any
2. Standardizing data for any column
3. Handling with null value
4. Removing columns or rows not necessary

### 4. Exploratory Data Analysis (EDA)
The EDA included an examination of the retail data to show diffrent aspects of the sales.
- **Customer Segmentation** :
   - Determine which segment of customer contribute the most to the revenue ( income, segment, group age)
   - Identify high-value customers and target them for marketing campaigns.
- **Sales Performance Analysis** :
   - Analyze revenue trends over time to identify peak sales periods
   - Determine which product brand has the highest revenue and which product category contribute to the most this revenue.
   - Determine the top-selling product by country, product brand   
- **Customer satisfaction** : Determine the overall average rating from customer, by country

### 5. Visualization
A detailed report with visualizations and insights derived from the dataset has been created on PowerBI

### 6. Results

The insights are summarized as follow :
##### NB: Same companies were observed in each country

- Companies located in USA combined the highest revenue over past year. In a list of the 20 companies with the highest revenue, 15 companies from the USA occupy the first 15 places. 
- In any country, PEPSI is the product brand that made the highest total amount from sales.
- Top three product brand are : **1. PEPSI  2. SAMSUNG  3. SONY**
- The top three selling-product driving the highest revenue and purchases are : **1. Water  2. Smartphone  3. Fiction books**
- The top selling product by category are: **1. Electronics - 2. Grocery - 3. Clothing - 4. Books - 5. Home decor**
- The revenue of companies fluctuate up and down over month.
  - Peak monthly sales : March 2023
  - Low monthly sales : February 2024
- A list of customer with the high lifetime value including their name, phone, email, address has been created for marketing promotion.
- Customers under 35 years old have contributed the most to the revenue
- In terms of revenues and purchases, if we consider the gender of customers, men are about twice as represented as women.
- Out of 5, the customer rating average is 3.16.
  
### 7. Challenges and Considerations:
**Data Quality**: Handling missing data, outliers, and inconsistencies in the dataset.
**Scalability**: Designing the analysis and models to handle large datasets efficiently.



