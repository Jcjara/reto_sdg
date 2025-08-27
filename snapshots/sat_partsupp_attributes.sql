{% snapshot sat_partsupp_attributes %}
{{
  config(
    unique_key = 'link_hk',
    strategy   = 'check',
    check_cols = ['avail_qty','supply_cost','comment'],
    invalidate_hard_deletes = True
  )
}}

SELECT
  -- composite HK (part + supplier)
  {{ hk256(['part_id','supplier_id']) }}  AS link_hk,

  -- entity HKs for clean downstream joins
  {{ hk256(['part_id']) }}                AS part_hk,
  {{ hk256(['supplier_id']) }}            AS supplier_hk,

  -- naturals (handy for debugging)
  part_id,
  supplier_id,

  -- attributes tracked in the sat (rename if your staging differs)
  avail_qty,
  supply_cost,
  comment,

  '{{ var("source_system") }}'              AS record_src
FROM {{ ref('stg_tpch__partsupp') }}

{% endsnapshot %}
