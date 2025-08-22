{% snapshot sat_region_attributes %}
{{
    config(
        unique_key='region_hk',
        strategy='check',
        check_cols=['region_name'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['r.region_id']) }} AS region_hk,
    r.region_name,
    {{ var('source_system') }}   AS record_src
FROM {{ ref('stg_tpch__region') }} r

{% endsnapshot %}
