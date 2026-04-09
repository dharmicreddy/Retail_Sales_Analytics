# Retail Sales Analytics Pipeline

End-to-end Databricks ETL pipeline using the Kaggle Online Retail II dataset 
(541,909 real UK e-commerce transactions, 2010–2011).

## Architecture
Kaggle Dataset → Bronze (raw Delta) → Silver (cleaned) → Gold (aggregated) → AI/BI Dashboard

## Pipeline Structure

| Notebook | Purpose |
|---|---|
| 00_setup_data | Downloads Kaggle dataset and saves to Delta table |
| 01_explore_data | EDA — null counts, schema, distributions |
| 02_bronze | Raw ingestion into bronze_retail Delta table |
| 03_silver | Cleaning, type casting, deduplication, derived columns |
| 04_gold | Business aggregations into 4 Gold tables |

## Gold Tables

| Table | Description | Rows |
|---|---|---|
| gold_monthly_revenue | Revenue by month and country | 287 |
| gold_top_products | Top products by revenue and units sold | 3,896 |
| gold_customer_rfm | Customer RFM segmentation (High/Mid/Low value) | 4,346 |
| gold_dow_sales | Sales pattern by day of week | 6 |

## Silver Layer — Transformations Applied
- Removed cancellation invoices (Invoice starting with "C")
- Removed null CustomerID (guest checkouts)
- Removed zero/negative Quantity and UnitPrice
- Deduplicated on InvoiceNo + StockCode
- Cast types — invoice_date to timestamp, customer_id to int
- Added derived columns — revenue, invoice_month, invoice_year, day_of_week

## Job
- Name: retail_etl_pipeline
- Schedule: Daily at 06:00 UTC
- Tasks: bronze → silver → gold (sequential with dependencies)

## Dashboard
- Name: Retail Sales Analytics
- Built on: Databricks AI/BI
- Charts: Monthly revenue trend, Top 20 products, Customer segments, Sales by day of week
- File: Retail Sales Analytics.lvdash.json

## Dataset
- Source: [Kaggle — Online Retail II](https://www.kaggle.com/datasets/carrie1/ecommerce-data)
- Records: 541,909 transactions
- Period: December 2010 – December 2011
- Region: Primarily United Kingdom (B2B retailer)

## How to Run
1. Clone this repo into a Databricks Git folder
2. Run 00_setup_data — enter your Kaggle username and API key when prompted
3. Run 02_bronze → 03_silver → 04_gold in order
4. Or trigger the retail_etl_pipeline Job which runs all steps automatically

## Tech Stack
- Databricks Community Edition
- Apache Spark / PySpark
- Delta Lake
- Databricks AI/BI Dashboards
- Databricks Workflows (Jobs)
- GitHub (version control)