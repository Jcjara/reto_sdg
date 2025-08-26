SELECT
    s.supplier_hk   AS supplier_sk,
    s.supplier_id,
    s.supplier_name,
    n.nation_name,
    r.region_name
FROM {{ ref('bv_supplier') }} s
LEFT JOIN {{ ref('bv_nation') }} n
  ON s.nation_id = n.nation_id
LEFT JOIN {{ ref('bv_region') }} r
  ON n.region_id = r.region_id
