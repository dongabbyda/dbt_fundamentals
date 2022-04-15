{%- macro clean_stale_dataset(schema=target.schema,days=3) -%}
    {% set drop_query %}
        select
            case 
                when table_type = 'VIEW'
                    then table_type
                else 
                    'TABLE'
            end as drop_type, 
            'DROP ' || drop_type || ' {{ database | upper }}.' || table_schema || '.' || table_name || ';'
        from {{ schema }}.INFORMATION_SCHEMA.TABLES
        where cast(creation_time as date) <= current_date - {{ days }}
    {% endset %} 

    {{log('\nGenerating select script...\n',info=True)}}

{%- endmacro -%}

