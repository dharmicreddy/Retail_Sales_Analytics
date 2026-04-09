sql_content = """
-- ============================================
-- Retail Sales Analytics Dashboard SQL Queries
-- ============================================

-- Dataset 1: monthly_revenue
-- Used for: Line chart — Monthly revenue trend
SELECT invoice_month,
       country,
       total_revenue,
       num_invoices,
       unique_customers
FROM   default.gold_monthly_revenue
WHERE  country IN ('United Kingdom','Germany','France',
                   'Netherlands','Australia')
ORDER BY invoice_month;


-- Dataset 2: top_products
-- Used for: Bar chart — Top 20 products by revenue
SELECT description,
       total_revenue,
       units_sold,
       num_orders
FROM   default.gold_top_products
ORDER BY total_revenue DESC
LIMIT  20;


-- Dataset 3: customer_segments
-- Used for: Pie chart — Customer value segments
SELECT segment,
       COUNT(*) AS num_customers,
       ROUND(AVG(monetary_value), 2) AS avg_spend,
       ROUND(SUM(monetary_value), 2) AS total_spend
FROM   default.gold_customer_rfm
GROUP BY segment
ORDER BY total_spend DESC;


-- Dataset 4: dow_sales
-- Used for: Bar chart — Sales by day of week
SELECT day_name,
       total_revenue,
       num_invoices
FROM   default.gold_dow_sales
ORDER BY day_of_week;
"""

with open("/tmp/dashboard_queries.sql", "w") as f:
    f.write(sql_content)

print("SQL file created ✓")
