{{ config(schema='star', materialized='table') }}

WITH n AS (
    SELECT nation_id, nation_name, region_id
    FROM {{ ref('stg_tpch__nation') }}
),
r AS (
    SELECT region_id, region_name
    FROM {{ ref('stg_tpch__region') }}
)
SELECT
    {{ hk256(['n.nation_id']) }} AS geography_sk,   -- nation grain
    n.nation_id                  AS nation_bk,
    n.nation_name,
    r.region_id,
    r.region_name
FROM n
LEFT JOIN r
  ON r.region_id = n.region_id
