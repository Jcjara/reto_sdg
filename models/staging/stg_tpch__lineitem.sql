SELECT
    l.l_orderkey      AS order_id,
    l.l_partkey       AS part_id,
    l.l_suppkey       AS supplier_id,
    l.l_linenumber    AS line_number,
    l.l_quantity      AS quantity,
    l.l_extendedprice AS extended_price,
    l.l_discount      AS discount,
    l.l_tax           AS tax,
    l.l_returnflag    AS return_flag,
    l.l_linestatus    AS line_status,
    l.l_shipdate      AS ship_date,
    l.l_commitdate    AS commit_date,
    l.l_receiptdate   AS receipt_date,
    l.l_shipinstruct  AS ship_instruct,
    l.l_shipmode      AS ship_mode,
    l.l_comment       AS comment
FROM {{ source('tpch', 'lineitem') }} AS l
