{% macro hd256(cols) -%}
-- HashDiff for satellites (Snowflake): HEX string of SHA-256
TO_VARCHAR(
  SHA2(
    {{ dbt_utils.generate_surrogate_key(cols) }}, 256
  )
)
{%- endmacro %}
