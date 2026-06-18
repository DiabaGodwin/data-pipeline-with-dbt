
-- dim_position_type.sql

with position_types as (

    select
        l_pos_type,
        max(position_type) as position_type
    from {{ ref('stg_global_liquidity_indicator') }}
    group by l_pos_type

)

select
    {{ dbt_utils.generate_surrogate_key(['l_pos_type']) }}
        as position_type_key,

    l_pos_type as position_type_code,
    position_type as position_type_name

from position_types
