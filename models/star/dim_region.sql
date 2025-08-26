SELECT
    r.region_hk   AS region_sk,
    r.region_id,
    r.region_name
FROM {{ ref('bv_region') }} r
