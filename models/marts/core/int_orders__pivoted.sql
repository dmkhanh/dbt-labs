{%- set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

with payments as (
    select * 
    from {{ ref("stg_payments") }}
)

, pivoted as (
    select
        order_id

        {%- for payment_method in payment_methods %}
        , sum(case when payment_method = '{{ payment_method }}' then amount end) as {{ payment_method }}_amount
        {%- endfor %}

    from payments
    group by order_id
)

select *
from pivoted