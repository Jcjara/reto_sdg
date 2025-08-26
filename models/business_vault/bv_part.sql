WITH s AS (
    SELECT
        part_hk,
        part_name,
        mfgr,
        brand,
        part_type,
        size,
        container,
        retail_price,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_part_attributes') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    h.part_hk,
    h.part_id,
    s.part_name,
    s.mfgr,
    s.brand,
    s.part_type,
    s.size,
    s.container,
    s.retail_price,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_part') }} h
LEFT JOIN s
  ON s.part_hk = h.part_hk
