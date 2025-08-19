{% snapshot sat_customer_attributes %}
  {{ config(
      target_schema='raw_vault',
      unique_key='customer_hk',
      strategy='check',
      check_cols=['NAME','ADDRESS','PHONE','ACCOUNT_BALANCE','MARKET_SEGMENT','NATION_ID']
  ) }}
  select
    {{ hk256(['customer_id']) }}          as customer_hk,
    customer_name                          as name,
    address,
    phone,
    account_balance,
    market_segment,
    nation_id,
    'TPCH_SF1'                             as record_src
  from {{ ref('stg_tpch__customer') }}
{% endsnapshot %}
