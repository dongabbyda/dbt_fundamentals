{%- macro cents_to_dollars(column_used,decimal_point) -%}
round(1.0*{{column_used}}/100,{{decimal_point}} )
{%- endmacro %}