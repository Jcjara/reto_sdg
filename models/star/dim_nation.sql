SELECT
    n.nation_hk   AS nation_sk,
    n.nation_id,
    n.nation_name,
    r.region_name
FROM {{ ref('bv_nation') }} n
LEFT JOIN {{ ref('bv_region') }} r
  ON n.region_id = r.region_id
