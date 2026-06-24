with instrument_types as (

    Select 
        type_of_instruments,
        max(l_instr) as l_instr

    from {{ref('stg_global_liquidity_indicator')}}
    group by type_of_instruments
)

Select
    {{ dbt_utils.generate_surrogate_key(['l_instr']) }} as l_instr_key, 
    type_of_instruments,
    l_instr
from instrument_types
