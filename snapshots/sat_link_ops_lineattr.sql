{% snapshot sat_link_ops_lineattr %}
{{
  config(
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
  {{ hk256(['l.order_id','l.part_id','l.supplier_id','l.line_number']) }} AS link_hk,
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
  {{ var('source_system') }} AS record_src
FROM {{ ref('stg_tpch__lineitem') }} l

{% endsnapshot %}
