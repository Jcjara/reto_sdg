{% snapshot sat_customer_attributes %}
{{
  config(
    unique_key = 'customer_hk',
    strategy   = 'check',
    check_cols = ['customer_name','nation_id','account_balance','market_segment','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__customer',
    hk_cols      = ['customer_id'],
    attrs        = ['customer_name','nation_id','account_balance','market_segment','comment'],
    hk_name      = 'customer_hk'
) }}

{% endsnapshot %}
