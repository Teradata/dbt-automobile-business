WITH cancellation_time AS (
  SELECT
    s.product_id,
    (s.cancelled_at - s.booked_at) DAY(4) AS cancellation_time_days
  FROM {{ ref('stg_purchases') }} s
  WHERE s.cancelled_at IS NOT NULL
    AND s.booked_at IS NOT NULL
),

product_cancellations AS (
  SELECT
    prod.make,
    c.cancellation_time_days
  FROM cancellation_time c
  JOIN {{ ref('stg_products') }} prod
    ON c.product_id = prod.id
)

SELECT
  make,
  AVG(cancellation_time_days) AS avg_cancellation_time_days
FROM product_cancellations
GROUP BY make
