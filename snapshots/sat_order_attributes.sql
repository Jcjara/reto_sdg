{% snapshot sat_order_attributes %}
{{
  config(
    unique_key = 'order_hk',
    strategy   = 'check',
    check_cols = ['order_status','order_date','order_priority','clerk','ship_priority','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__orders',
    hk_cols      = ['order_id'],
    attrs        = ['order_status','order_date','order_priority','clerk','ship_priority','comment'],
    hk_name      = 'order_hk'
) }}

{% endsnapshot %}
