WITH product_cast AS (
  SELECT
    products_id,
    SAFE_CAST(REGEXP_REPLACE(REPLACE(purchse_price, ',', '.'), r'[^0-9.\-]', '') AS NUMERIC) AS purchase_price
  FROM {{ ref("stg_gz_raw_data__raw_gz_product") }}
),
sales AS (
  SELECT
    date_date,
    orders_id,
    pdt_id,
    revenue,
    quantity
  FROM {{ ref("stg_gz_raw_data__raw_gz_sales") }}
)
SELECT
  s.pdt_id,
  p.products_id,
  s.date_date,
  s.orders_id,
  s.revenue,
  s.quantity,
  p.purchase_price,
  ROUND(s.quantity * p.purchase_price, 2) AS purchase_cost,
  ROUND(s.revenue - s.quantity * p.purchase_price, 2) AS margin
FROM sales s
LEFT JOIN product_cast p
  ON p.products_id = s.pdt_id