--dim_date.sql

select 
    {{ dbt_utils.generate_surrogate_key(['issued_date']) }} as date_key,
    extract(year from issued_date ) as year,
    extract(quarter from issued_date) as quarter,
    extract(month from issued_date)   as month
from {{ref('stg_global_liquidity_indicator')}}


