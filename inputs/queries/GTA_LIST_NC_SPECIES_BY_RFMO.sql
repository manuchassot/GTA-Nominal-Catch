SELECT DISTINCT nc.source_authority AS "RFMO", nc.species_group AS "SPECIES_GROUP_CODE", sg.label AS "SPECIES_GROUP", sp.taxa_order AS "ORDER", sp.taxa_family AS "FAMILY", nc.species AS "SPECIES_CODE", sp.label AS "SPECIES", sp.taxa_scientific_name AS "SPECIES_SCIENTIFIC"
FROM fact_tables.global_nominal_catch_firms_level0 nc
LEFT JOIN species.species_asfis sp ON (nc.species = sp.code)
LEFT JOIN species.speciesgroup_tunaatlas sg ON (nc.species_group = sg.code)
WHERE sp.label NOT LIKE '%nei'
ORDER BY sg.label, nc.species;