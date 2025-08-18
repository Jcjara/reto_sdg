{% macro hk256(cols) -%}
-- Snowflake: SHA2() returns BINARY; TO_VARCHAR(binary) => HEX string
TO_VARCHAR(
  SHA2(
    {{ dbt_utils.generate_surrogate_key(cols) }}, 256
  )
)
{%- endmacro %}
