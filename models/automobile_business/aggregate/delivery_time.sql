WITH delivery_times AS (
  SELECT
    p.product_id,
    (p.purchased_at - p.booked_at) DAY(4) AS delivery_time_days
  FROM {{ ref('stg_purchases') }} p
  WHERE p.purchased_at IS NOT NULL
    AND p.booked_at IS NOT NULL
),

product_delivery_times AS (
  SELECT
    prod.make,
    AVG(d.delivery_time_days) AS avg_delivery_time_days
  FROM delivery_times d
  JOIN {{ ref('stg_products') }} prod
    ON d.product_id = prod.id
  GROUP BY prod.make
)

SELECT
  make,
  avg_delivery_time_days
FROM product_delivery_times