SELECT source_authority AS "RFMO", min(Year) AS START_YEAR, max(Year) AS END_YEAR
FROM fact_tables.global_nominal_catch_firms_level0 nc
GROUP BY source_authority
ORDER BY source_authority;