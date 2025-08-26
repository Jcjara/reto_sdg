{% snapshot sat_link_order_part_supplier %}
{{
  config(
    unique_key = 'link_hk',
    strategy   = 'check',
    check_cols = [
      'quantity','extended_price','discount','tax',
      'return_flag','line_status','ship_date','commit_date','receipt_date',
      'ship_instruct','ship_mode','comment'
    ],
    invalidate_hard_deletes = True
  )
}}

{{ dv_platform.dv_sat_select(
    src_ref_name = 'stg_tpch__lineitem',
    hk_cols      = ['order_id','part_id','supplier_id','line_number'],
    attrs        = [
      'quantity','extended_price','discount','tax',
      'return_flag','line_status','ship_date','commit_date','receipt_date',
      'ship_instruct','ship_mode','comment'
    ],
    hk_name      = 'link_hk'
) }}

{% endsnapshot %}
