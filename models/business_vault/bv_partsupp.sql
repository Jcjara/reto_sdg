WITH current_sat AS (
    SELECT
        part_hk,
        supplier_hk,
        avail_qty,
        supply_cost,
        record_src,
        dbt_valid_from AS start_dt,
        dbt_valid_to   AS end_dt
    FROM {{ ref('sat_partsupp_attributes') }}
    WHERE dbt_valid_to IS NULL
),
filtered AS (
    SELECT *
    FROM current_sat
    WHERE part_hk IS NOT NULL
      AND supplier_hk IS NOT NULL
),
dedup AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
          PARTITION BY part_hk, supplier_hk
          ORDER BY start_dt DESC
        ) AS rn
    FROM filtered
)
SELECT
    part_hk,
    supplier_hk,
    avail_qty,
    supply_cost,
    record_src,
    start_dt,
    end_dt
FROM dedup
WHERE rn = 1
