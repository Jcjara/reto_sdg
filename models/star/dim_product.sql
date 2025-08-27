SELECT
    p.part_hk          AS product_sk,
    p.part_name,
    p.brand,
    p.part_type,
    p.size,
    p.container,
    p.retail_price,
    ps.supplier_hk,
    ps.avail_qty,
    ps.supply_cost
FROM {{ ref('bv_part') }} p
LEFT JOIN {{ ref('bv_partsupp') }} ps
    ON p.part_hk = ps.part_hk
