{% test receipt_on_or_after_ship(model, column_name, receipt_col, ship_col) %}
select *
from {{ model }}
where {{ receipt_col }} is not null
  and {{ ship_col }} is not null
  and {{ receipt_col }} < {{ ship_col }}
{% endtest %}
