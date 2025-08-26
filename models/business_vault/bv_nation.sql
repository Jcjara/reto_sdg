WITH s AS (
    SELECT
        nation_hk,
        nation_name,
        region_id,
        comment,
        dbt_valid_from,
        dbt_valid_to
    FROM {{ ref('sat_nation_attributes') }}
    WHERE dbt_valid_to IS NULL
)

SELECT
    h.nation_hk,
    h.nation_id,
    s.nation_name,
    s.region_id,
    s.comment,
    s.dbt_valid_from AS start_dt,
    s.dbt_valid_to   AS end_dt
FROM {{ ref('hub_nation') }} h
LEFT JOIN s
  ON s.nation_hk = h.nation_hk
