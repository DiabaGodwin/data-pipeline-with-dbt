--dim_lender_sector.sql

with lenders_sectors as ( 

    select 
        lenders_sector_code, 
        max(lending_sector) as lending_sector 

    from {{ ref('stg_global_liquidity_indicator') }}
    group by lenders_sector_code

) 

select  
    {{ dbt_utils.generate_surrogate_key(['lenders_sector_code']) }} as lender_sector_key, 
    lenders_sector_code, 
    lending_sector

from lenders_sectors
