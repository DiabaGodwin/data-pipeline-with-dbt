
-- dim_country.sql


with borrowers_sectors as (

    select
        borrowers_sector_code,
        max(borrowers_sector) as borrowers_sector
    from {{ ref('stg_global_liquidity_indicator') }}
    group by borrowers_sector_code

)

select
    {{ dbt_utils.generate_surrogate_key(['borrowers_sector_code']) }}
        as borrowers_sector_key,

    borrowers_sector_code,
    borrowers_sector
from borrowers_sectors