SELECT
    l.link_hk,
    l.order_hk,
    l.part_hk,
    l.supplier_hk,
    s.quantity,
    s.extended_price,
    s.discount,
    s.tax,
    s.return_flag,
    s.line_status,
    s.ship_date,
    s.commit_date,
    s.receipt_date,
    s.ship_instruct,
    s.ship_mode,
    s.comment,
    s.extended_price                                  AS gross_sales,
    s.extended_price * (1 - s.discount)               AS net_of_discount,
    s.extended_price * (1 - s.discount) * (1 + s.tax) AS net_sales,
    s.extended_price * s.discount                     AS discount_amount,
    s.extended_price * (1 - s.discount) * s.tax       AS tax_amount
FROM {{ ref('link_order_part_supplier') }} l
LEFT JOIN {{ ref('sat_link_order_part_supplier') }} s
    ON s.link_hk = l.link_hk
    AND s.dbt_valid_to IS NULL
