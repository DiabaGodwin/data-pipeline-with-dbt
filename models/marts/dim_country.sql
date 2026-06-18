-- dim_country.sql



with countries as (

    select
        borrowers_cty,
        max(borrowers_country) as borrowers_country
    from {{ ref('stg_global_liquidity_indicator') }}
    group by borrowers_cty

)

select
    {{ dbt_utils.generate_surrogate_key(['borrowers_cty']) }}
        as country_key,

    borrowers_cty as country_code,
    borrowers_country as country_name

from countries