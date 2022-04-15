{%- macro limit_data_in_dev(col_name,dev_days) -%}
{%- if target.name == 'default' -%}
where {{col_name}} >= date_add(current_date,INTERVAL -{{dev_days}} day)
{%- endif -%}
{%- endmacro -%}