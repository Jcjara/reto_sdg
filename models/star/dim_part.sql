SELECT
    p.part_hk       AS part_sk,
    p.part_id,
    p.part_name,
    p.brand,
    p.part_type,
    p.size,
    p.container,
    p.retail_price
FROM {{ ref('bv_part') }} p
