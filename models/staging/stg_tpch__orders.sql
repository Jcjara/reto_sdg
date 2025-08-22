SELECT
    o.o_orderkey     AS order_id,
    o.o_custkey      AS customer_id,
    o.o_orderstatus  AS order_status,
    o.o_totalprice   AS total_price,
    o.o_orderdate    AS order_date,
    o.o_orderpriority AS order_priority,
    o.o_clerk        AS clerk,
    o.o_shippriority AS ship_priority,
    o.o_comment      AS comment
FROM {{ source('tpch', 'orders') }} AS o
