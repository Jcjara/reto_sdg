{{ config(schema='business_vault', materialized='view') }}

with li as (
  select
    order_id,
    part_id,
    supplier_id,
    line_number,
    {{ hk256(['order_id','part_id','supplier_id','line_number']) }} as link_hk,
    {{ hk256(['order_id']) }}    as order_hk,
    {{ hk256(['part_id']) }}     as part_hk,
    {{ hk256(['supplier_id']) }} as supplier_hk,

    quantity,
    extended_price,
    discount,
    tax,
    return_flag,
    line_status,
    ship_date,
    commit_date,
    receipt_date,
    ship_instruct,
    ship_mode,
    comment
  from {{ ref('stg_tpch__lineitem') }}
),
o as (
  select
    order_id,
    {{ hk256(['order_id']) }} as order_hk,
    {{ hk256(['customer_id']) }} as customer_hk,
    order_date
  from {{ ref('stg_tpch__orders') }}
),
sat_line as (
  -- current line attributes from the snapshot view
  select *
  from {{ ref('sat_link_ops_lineattr_view') }}
  where is_current = true
)

select
  li.link_hk,
  li.order_hk,
  li.part_hk,
  li.supplier_hk,
  o.customer_hk,

  o.order_date,
  li.ship_date,
  li.receipt_date,

  -- measures
  li.quantity,
  li.extended_price                                 as gross_sales,
  li.extended_price * li.discount                   as discount_amount,
  (li.extended_price - (li.extended_price * li.discount)) * li.tax  as tax_amount,
  (li.extended_price * (1 - li.discount)) + ((li.extended_price * (1 - li.discount)) * li.tax) as net_sales,

  -- useful flags/attrs
  li.return_flag,
  li.line_status,
  li.ship_mode
from li
join o
  on li.order_id = o.order_id
left join sat_line s
  on s.link_hk = li.link_hk
