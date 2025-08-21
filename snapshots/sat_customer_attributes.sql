{% snapshot sat_customer_attributes %}
{{
  config(
    target_schema='raw_vault',
    unique_key='customer_hk',
    strategy='check',
    check_cols=['customer_name','nation_id','account_balance','market_segment','comment'],
    invalidate_hard_deletes=True
  )
}}

SELECT
  {{ hk256(['customer_id']) }} AS customer_hk,
  c.customer_name,
  c.nation_id,
  c.account_balance,
  c.market_segment,
  c.comment,
  'stg_tpch__customer' AS record_src
FROM {{ ref('stg_tpch__customer') }} c
{% endsnapshot %}
