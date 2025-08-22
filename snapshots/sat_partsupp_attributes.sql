{% snapshot sat_partsupp_attributes %}
{{
    config(
        unique_key='link_hk',
        strategy='check',
        check_cols=['avail_qty', 'supply_cost'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['ps.part_id','ps.supplier_id']) }} AS link_hk,
    ps.avail_qty,
    ps.supply_cost,
    {{ var('source_system') }}                   AS record_src
FROM {{ ref('stg_tpch__partsupp') }} ps

{% endsnapshot %}
