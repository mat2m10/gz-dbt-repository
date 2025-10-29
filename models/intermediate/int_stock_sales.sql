SELECT *
FROM
{{ref("stg_gz_raw_data__raw_gz_sales")}}
JOIN
{{ref("stg_gz_raw_data__raw_gz_ship")}}
USING (orders_id)