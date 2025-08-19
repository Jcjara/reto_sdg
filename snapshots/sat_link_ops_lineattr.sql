{% snapshot sat_link_ops_lineattr %}
  {{ config(
      target_schema='raw_vault',
      unique_key='link_hk',
      strategy='check',
      check_cols=['QUANTITY','EXTENDED_PRICE','DISCOUNT','TAX','RETURN_FLAG','LINE_STATUS',
                  'SHIP_DATE','COMMIT_DATE','RECEIPT_DATE','SHIP_INSTRUCT','SHIP_MODE','COMMENT']
  ) }}

  with base as (
    select
      order_id, part_id, supplier_id, line_number,
      quantity, extended_price, discount, tax,
      return_flag, line_status, ship_date, commit_date, receipt_date,
      ship_instruct, ship_mode, comment
    from {{ ref('stg_tpch__lineitem') }}
  )
  select
    {{ hk256(['order_id','part_id','supplier_id','line_number']) }} as link_hk,
    quantity, extended_price, discount, tax,
    return_flag, line_status, ship_date, commit_date, receipt_date,
    ship_instruct, ship_mode, comment,
    'TPCH_SF1' as record_src
  from base
{% endsnapshot %}
