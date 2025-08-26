SELECT
    s.s_suppkey      AS supplier_id,
    s.s_name         AS supplier_name,
    s.s_address      AS address,
    s.s_nationkey    AS nation_id,
    s.s_phone        AS phone,
    s.s_acctbal      AS account_balance,
    s.s_comment      AS comment
FROM {{ source('tpch', 'supplier') }} AS s
