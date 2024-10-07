WITH comparison AS (
  SELECT
    c.make,
    c.avg_cancellation_time_days,
    d.avg_delivery_time_days,
    (c.avg_cancellation_time_days - d.avg_delivery_time_days) AS difference
  FROM {{ ref('cancellation_time') }} c
  JOIN {{ ref('delivery_time') }} d
    ON c.make = d.make
)

SELECT
  make,
  avg_cancellation_time_days,
  avg_delivery_time_days,
  difference
FROM comparison
WHERE difference < 0