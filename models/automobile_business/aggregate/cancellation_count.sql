WITH cancellations AS (
  SELECT
    product_id,
    COUNT(user_id) AS cancellation_count
  FROM {{ ref('stg_purchases') }}
  WHERE cancelled_at IS NOT NULL
  GROUP BY product_id
),

product_cancellations AS (
  SELECT
    p.id AS product_id,
    p.make,
    p.model,
    c.cancellation_count
  FROM {{ ref('stg_products') }} p
  LEFT JOIN cancellations c ON p.id = c.product_id
)

SELECT
  product_id,
  make,
  model,
  COALESCE(cancellation_count, 0) AS cancellation_count
FROM product_cancellations