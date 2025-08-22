{% snapshot sat_supplier_attributes %}
{{
    config(
        unique_key='supplier_hk',
        strategy='check',
        check_cols=['name', 'address', 'nation_id', 'phone', 'account_balance'],
        invalidate_hard_deletes=True
    )
}}

SELECT
    {{ hk256(['s.supplier_id']) }} AS supplier_hk,
    s.name,
    s.address,
    s.nation_id,
    s.phone,
    s.account_balance,
    {{ var('source_system') }}     AS record_src
FROM {{ ref('stg_tpch__supplier') }} s

{% endsnapshot %}
