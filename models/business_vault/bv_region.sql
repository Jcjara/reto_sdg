WITH s AS (
    SELECT
        region_hk,
        region_name,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_region_attributes') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    h.region_hk,
    h.region_id,
    s.region_name,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_region') }} h
LEFT JOIN s
  ON s.region_hk = h.region_hk
