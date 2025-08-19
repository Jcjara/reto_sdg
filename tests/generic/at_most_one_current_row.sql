{% test at_most_one_current_row(model, key) %}
with counts as (
  select
    {{ key }} as k,
    count_if(dbt_valid_to is null) as open_rows
  from {{ model }}
  group by 1
)
select *
from counts
where open_rows > 1
{% endtest %}
