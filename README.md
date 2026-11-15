# Food Delivery Data Analysis Using SQL

## Project Overview

This project focuses on analysing food delivery data using **MySQL**.

The main objective is to analyse customer activity, restaurant performance, orders, delivery operations, rider performance, and revenue using SQL queries.

The project demonstrates practical SQL skills, including data auditing, data cleaning, joins, aggregations, subqueries, CTEs, and window functions.

## Project Objectives

- Understand the structure of food delivery datasets.
- Identify missing, duplicate, and inconsistent data.
- Perform data cleaning and preprocessing.
- Analyse overall order and revenue performance.
- Explore customer purchasing behaviour.
- Analyse restaurant performance.
- Evaluate delivery and rider performance.
- Identify time-based ordering patterns.
- Generate meaningful business insights.

## Tools and Technologies Used

- **MySQL** – Database management
- **SQL** – Data analysis and querying
- **CSV** – Dataset format

## Dataset Information

This project uses five related CSV datasets:

1. `customers.csv`
2. `restaurants.csv`
3. `orders.csv`
4. `riders.csv`
5. `deliveries.csv`

### Database Tables

- Customers
- Restaurants
- Orders
- Riders
- Deliveries

These tables are connected using primary and foreign-key relationships.

## Project Workflow

```text
Raw Datasets
     |
     v
Database Creation
     |
     v
Table Creation
     |
     v
Data Import
     |
     v
Data Auditing
     |
     v
Data Cleaning
     |
     v
Business Analysis
     |
     v
Advanced SQL Analysis
     |
     v
Business Insights
```

## Analysis Performed

### 1. Database and Table Creation

- Created the database.
- Created tables for customers, restaurants, orders, riders, and deliveries.
- Defined primary keys and foreign keys.
- Established relationships between tables.

### 2. Data Auditing

- Checked total row counts.
- Identified NULL values.
- Checked empty strings.
- Identified duplicate records.
- Checked invalid values.
- Verified foreign-key relationships.
- Checked order and delivery status values.
- Identified invalid amounts.
- Checked date and time values.
- Checked duplicate IDs.

### 3. Data Cleaning

- Standardized inconsistent city names.
- Checked and handled empty values.
- Created cleaned tables.
- Preserved meaningful blank delivery times for deliveries that were not completed.
- Verified relationships after cleaning.

Cleaned tables use the `_sc` naming convention.

Examples:

- `customers_sc`
- `restaurants_sc`
- `orders_sc`
- `riders_sc`
- `deliveries_sc`

### 4. Overall Business Analysis

- Total number of orders.
- Total revenue.
- Average order value.
- Order status distribution.
- Delivery status distribution.
- Delivery success rate.
- Percentage of unsuccessful deliveries.

### 5. Customer Analysis

- Total registered customers.
- Customers who placed orders.
- Monthly customer registrations.
- Yearly customer registrations.
- Top-spending customers.
- Customers with the highest number of orders.

### 6. Restaurant Analysis

- Restaurants with the highest number of orders.
- Restaurants generating the highest revenue.
- Average order value by restaurant.
- Orders by restaurant city.
- Revenue by restaurant city.
- Restaurants performing above the average order value.
- Restaurants generating more revenue than the overall average.

### 7. Delivery Analysis

- Delivery status distribution.
- Delivery success rate.
- Undelivered deliveries.
- Riders with the highest number of unsuccessful deliveries.
- Undelivered deliveries by restaurant city.
- Most frequent delivery hours.

### 8. Rider Analysis

- Monthly rider registrations.
- Riders completing the highest number of deliveries.
- Riders with the highest number of unsuccessful deliveries.
- Total deliveries handled by each rider.
- Delivery success rate by rider.
- Comparison of rider delivery volume and success rate.

### 9. Time-Based Analysis

- Monthly order trends.
- Orders by weekday.
- Orders by hour.
- Monthly revenue analysis.
- Identification of peak ordering periods.

### 10. Advanced SQL Analysis

- Rank restaurants by revenue within each city.
- Find top-performing restaurants in each city.
- Calculate restaurant revenue contribution.
- Compare restaurant performance against overall averages.
- Compare rider delivery volume with delivery success rates.
- Analyse customers based on spending and order frequency.

## SQL Concepts Used

This project demonstrates practical knowledge of:

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- DISTINCT
- COUNT()
- SUM()
- AVG()
- JOIN
- LEFT JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK()
- PARTITION BY
- Date Functions
- Time Functions
- UPDATE
- Aggregate Functions
- Conditional Aggregation

## Project Structure

```text
Food_Delivery_SQL_Analysis/
│
├── data/
│   ├── customers.csv
│   ├── restaurants.csv
│   ├── orders.csv
│   ├── riders.csv
│   └── deliveries.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_audit.sql
│   ├── 03_data_cleaning.sql
│   └── 04_analysis.sql
│
└── README.md
```

## Key Skills Demonstrated

- SQL querying
- Relational database management
- Data auditing
- Data cleaning
- Data validation
- Joins and relationships
- Aggregate analysis
- Subqueries and CTEs
- Window functions
- Business analysis
- Problem-solving
- Business insight generation

## Conclusion

This project demonstrates an end-to-end SQL data analysis workflow, starting from database creation and data auditing to data cleaning and advanced business analysis.

The analysis explores customer behaviour, restaurant performance, revenue, delivery operations, rider performance, and ordering patterns.

This project helped develop practical SQL skills and the ability to convert business questions into meaningful SQL queries.

---

## Author

**Sharan S**

Aspiring Data Analyst

**Skills:** SQL | Python | Excel | Tableau | Data Analysis

**GitHub:** https://github.com/sharan161
