with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select
        order_id,
        {% set payment_methods = ['bank_transfer','coupon_amount','credit_card','gift_card'] %}
        {%- for payment_method in payment_methods -%}
        sum(case when payment_method = '{{payment_method}}' then amount else 0 end) {{payment_method}}_amount
        {%-if not loop.last -%} , {%-endif %}
        {% endfor -%}
    from payments
    where status = 'success'
    group by 1
)

select * from pivoted