{% snapshot sat_link_ops_lineattr %}
{{
  config(
    target_schema='raw_vault',
    unique_key='link_hk',
    strategy='check',
    check_cols=[
      'quantity','extended_price','discount','tax',
      'return_flag','line_status','ship_date','commit_date','receipt_date',
      'ship_instruct','ship_mode','comment'
    ],
    invalidate_hard_deletes=True
  )
}}

SELECT
  -- Link grain: order-part-supplier + line_number
  {{ hk256(['order_id','part_id','supplier_id','line_number']) }} AS link_hk,
  l.quantity,
  l.extended_price,
  l.discount,
  l.tax,
  l.return_flag,
  l.line_status,
  l.ship_date,
  l.commit_date,
  l.receipt_date,
  l.ship_instruct,
  l.ship_mode,
  l.comment,
  'stg_tpch__lineitem' AS record_src
FROM {{ ref('stg_tpch__lineitem') }} l
{% endsnapshot %}
