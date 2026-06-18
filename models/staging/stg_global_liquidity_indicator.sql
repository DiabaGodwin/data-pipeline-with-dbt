WITH flattened_data AS (
    SELECT
        series,
        frequency,
        curr_denom,
        borrowers_cty,
        borrowers_country,
        borrowers_sector,
        borrowers_sector_code,
        lenders_sector,
        title,
        availability,
        l_pos_type,
        position_type,
        l_instr,
        unit_measure,
        j.key AS json_key,
        j.value AS json_value
    FROM {{ source("data-engineering-path", "raw_global_liquidity") }} r
    CROSS JOIN LATERAL jsonb_each_text(to_jsonb(r)) j
    WHERE j.key ~ '^\d{4}-Q[1-4]$'
      AND j.value <> ''
)

SELECT
    series,
    frequency,
    curr_denom,
    borrowers_cty,
    borrowers_country,
    borrowers_sector,
    borrowers_sector_code,
    lenders_sector,
    title,
    availability,
    l_pos_type,
    position_type,
    l_instr,
    unit_measure,

    CASE right(json_key, 2)
        WHEN 'Q1' THEN make_date(split_part(json_key,'-',1)::int, 1, 1)
        WHEN 'Q2' THEN make_date(split_part(json_key,'-',1)::int, 4, 1)
        WHEN 'Q3' THEN make_date(split_part(json_key,'-',1)::int, 7, 1)
        WHEN 'Q4' THEN make_date(split_part(json_key,'-',1)::int, 10, 1)
    END as issued_date,

    NULLIF(json_value, '')::numeric as amount
FROM flattened_data
