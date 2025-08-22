WITH li AS (
    SELECT
        l.order_id,
        l.part_id,
        l.supplier_id,
        l.line_number,
        l.quantity,
        l.extended_price,
        l.discount,
        l.tax,
        l.return_flag,
        l.line_status,
        l.ship_date,
        l.commit_date,
        l.receipt_date,
        l.ship_instruct,
        l.ship_mode,
        l.comment
    FROM {{ ref('stg_tpch__lineitem') }} l
),
o AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date
    FROM {{ ref('stg_tpch__orders') }} o
),
cust_sat AS (
    SELECT
        sc.customer_hk,
        sc.market_segment
    FROM {{ ref('sat_customer_attributes_view') }} sc
    WHERE sc.is_current
),
part AS (
    SELECT
        p.part_id,
        p.brand,
        p.manufacturer,
        p.part_type
    FROM {{ ref('stg_tpch__part') }} p
)
SELECT
    -- Hash keys (HK-as-SK pattern downstream)
    {{ hk256(['o.customer_id']) }}                      AS customer_hk,
    {{ hk256(['li.part_id']) }}                         AS part_hk,
    {{ hk256(['li.supplier_id']) }}                     AS supplier_hk,
    {{ hk256(['o.order_id']) }}                         AS order_hk,
    {{ hk256(['li.order_id','li.part_id','li.supplier_id','li.line_number']) }} AS link_hk,

    -- Dates / descriptors
    o.order_date,
    li.ship_date,
    li.receipt_date,
    li.ship_mode,
    li.return_flag,
    li.line_status,

    -- Descriptive enrichments
    part.brand,
    part.manufacturer,
    part.part_type,
    cust_sat.market_segment,

    -- Measures (explicit)
    li.quantity                                           AS quantity,
    li.extended_price                                     AS gross_sales,
    (li.extended_price * li.discount)                     AS discount_amount,
    ((li.extended_price * (1 - li.discount)) * li.tax)    AS tax_amount,
    ((li.extended_price * (1 - li.discount)) * (1 + li.tax)) AS net_sales
FROM li
LEFT JOIN o
  ON o.order_id = li.order_id
LEFT JOIN cust_sat
  ON cust_sat.customer_hk = {{ hk256(['o.customer_id']) }}
LEFT JOIN part
  ON part.part_id = li.part_id
