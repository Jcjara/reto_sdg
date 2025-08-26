WITH s AS (
    SELECT
        order_hk,
        order_status,
        order_date,
        order_priority,
        clerk,
        ship_priority,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_order_attributes') }}
    WHERE dbt_valid_to IS NULL
),

lc AS (
    SELECT
        order_hk,
        customer_hk
    FROM {{ ref('link_orders_customer') }}
)
SELECT
    h.order_hk,
    h.order_id,
    lc.customer_hk,
    s.order_status,
    s.order_date,
    s.order_priority,
    s.clerk,
    s.ship_priority,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_orders') }} h
LEFT JOIN s
  ON s.order_hk = h.order_hk
LEFT JOIN lc
  ON lc.order_hk = h.order_hk
