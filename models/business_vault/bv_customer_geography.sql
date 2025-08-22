WITH c AS (
    SELECT
        c.customer_id,
        c.nation_id
    FROM {{ ref('stg_tpch__customer') }} c
),
n AS (
    SELECT
        n.nation_id,
        n.nation_name,
        n.region_id
    FROM {{ ref('stg_tpch__nation') }} n
),
r AS (
    SELECT
        r.region_id,
        r.region_name
    FROM {{ ref('stg_tpch__region') }} r
)
SELECT
    {{ hk256(['c.customer_id']) }} AS customer_hk,
    c.customer_id,
    n.nation_id,
    n.nation_name,
    r.region_id,
    r.region_name
FROM c
LEFT JOIN n ON n.nation_id = c.nation_id
LEFT JOIN r ON r.region_id = n.region_id
