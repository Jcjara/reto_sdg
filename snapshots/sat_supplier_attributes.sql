{% snapshot sat_supplier_attributes %}
{{
  config(
    unique_key = 'supplier_hk',
    strategy   = 'check',
    check_cols = ['supplier_name','address','nation_id','phone','account_balance','comment'],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__supplier',
    hk_cols      = ['supplier_id'],
    attrs        = ['supplier_name','address','nation_id','phone','account_balance','comment'],
    hk_name      = 'supplier_hk'
) }}

{% endsnapshot %}
