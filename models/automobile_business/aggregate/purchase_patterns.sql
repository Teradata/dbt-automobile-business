SELECT 
  user_id,
  product_id,
  purchased_at,
  booked_at,
  cancelled_at,
(purchased_at - booked_at) DAY(4) AS time_to_purchase_days
FROM {{ ref('stg_purchases') }}





