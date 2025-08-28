{% macro auto_staging_select(database, schema, table, casts=none) %}
  {# casts is an optional dict: { 'col_name': 'TYPE' } #}
  {% set q %}
    SELECT column_name, data_type
    FROM {{ database }}.INFORMATION_SCHEMA.COLUMNS
    WHERE table_schema = upper('{{ schema }}')
      AND table_name   = upper('{{ table }}')
    ORDER BY ordinal_position
  {% endset %}

  {% set res = run_query(q) %}
  {% if res is none %}
    {% do exceptions.raise("auto_staging_select: run_query returned None. Check your connection/permissions.") %}
  {% endif %}

  {% set rows = res.rows %}

  {# Build the select list #}
  {% for r in rows %}
    {% set col = r[0] %}
    {% set alias = col | lower %}  {# adjust to your naming convention #}

    {% if casts and alias in casts %}
      CAST({{ col }} AS {{ casts[alias] }}) AS {{ adapter.quote(alias) }}
    {% else %}
      {{ adapter.quote(col) }} AS {{ adapter.quote(alias) }}
    {% endif %}
    {% if not loop.last %},{% endif %}
  {% endfor %}
{% endmacro %}
