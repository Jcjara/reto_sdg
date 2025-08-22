{% snapshot sat_nation_attributes %}
{{
    config(
        unique_key='nation_hk',
        strategy='check',
        check_cols=['nation_name', 'region_id'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['n.nation_id']) }} AS nation_hk,
    n.nation_name,
    n.region_id,
    {{ var('source_system') }}   AS record_src
FROM {{ ref('stg_tpch__nation') }} n

{% endsnapshot %}
