SELECT
    nation_hk,
    nation_name,
    region_id,
    dbt_valid_from AS start_dt,
    dbt_valid_to   AS end_dt,
    dbt_valid_to IS NULL AS is_current,
    record_src
FROM {{ ref('sat_nation_attributes') }}
