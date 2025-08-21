{% snapshot sat_partsupp_attributes %}
{{
    config(
        target_schema='raw_vault',
        unique_key='link_hk',
        strategy='check',
        check_cols=['avail_qty', 'supply_cost'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['ps.part_id', 'ps.supplier_id']) }} AS link_hk,
    ps.avail_qty,
    ps.supply_cost,
    'stg_tpch__partsupp' AS record_src
FROM {{ ref('stg_tpch__partsupp') }} ps

{% endsnapshot %}
