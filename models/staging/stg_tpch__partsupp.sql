SELECT
    ps.ps_partkey    AS part_id,
    ps.ps_suppkey    AS supplier_id,
    ps.ps_availqty   AS avail_qty,
    ps.ps_supplycost AS supply_cost,
    ps.ps_comment    AS comment
FROM {{ source('tpch', 'partsupp') }} AS ps
