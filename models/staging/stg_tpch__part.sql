SELECT
    p.p_partkey      AS part_id,
    p.p_name         AS part_name,
    p.p_mfgr         AS mfgr,
    p.p_brand        AS brand,
    p.p_type         AS part_type,
    p.p_size         AS size,
    p.p_container    AS container,
    p.p_retailprice  AS retail_price,
    p.p_comment      AS comment
FROM {{ source('tpch', 'part') }} AS p
