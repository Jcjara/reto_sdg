SELECT
    l.link_hk          AS sales_sk,
    o.order_hk,
    c.customer_hk,
    p.part_hk,
    s.supplier_hk,
    l.extended_price,
    l.discount,
    l.tax,
    l.quantity,
    l.return_flag,
    l.line_status,
    l.ship_date,
    l.commit_date,
    l.receipt_date,
    l.ship_mode,
    o.order_date
FROM {{ ref('bv_lineitem') }} l
LEFT JOIN {{ ref('bv_order') }} o
  ON l.order_hk = o.order_hk
LEFT JOIN {{ ref('bv_customer') }} c
  ON o.customer_hk = c.customer_hk
LEFT JOIN {{ ref('bv_part') }} p
  ON l.part_hk = p.part_hk
LEFT JOIN {{ ref('bv_supplier') }} s
  ON l.supplier_hk = s.supplier_hk
