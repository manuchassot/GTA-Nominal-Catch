WITH SPECIES_RFMOS AS
(SELECT DISTINCT nc.source_authority AS "RFMO", nc.species_group AS "SPECIES_GROUP_CODE",
 sg.label AS "SPECIES_GROUP", sp.order_ AS "ORDER", sp.family AS "FAMILY",
 nc.species AS "SPECIES_CODE", sp.label AS "SPECIES", sp.scientific_name AS "SPECIES_SCIENTIFIC"
FROM fact_tables.global_nominal_catch_firms_level0 nc
LEFT JOIN species.species_asfis sp ON (nc.species = sp.code)
LEFT JOIN species.speciesgroup_tunaatlas sg ON (nc.species_group = sg.code)
WHERE sp.label NOT LIKE '%nei'
ORDER BY sg.label, nc.species
)

SELECT "SPECIES_GROUP",
SUM(CASE WHEN "RFMO" LIKE 'IATTC' THEN 1 ELSE 0 END) AS "IATTC",
SUM(CASE WHEN "RFMO" LIKE 'ICCAT' THEN 1 ELSE 0 END) AS "ICCAT",
SUM(CASE WHEN "RFMO" LIKE 'IOTC' THEN 1 ELSE 0 END) AS "IOTC",
SUM(CASE WHEN "RFMO" LIKE 'CCSBT' THEN 1 ELSE 0 END) AS "CCSBT",
SUM(CASE WHEN "RFMO" LIKE 'WCPFC' THEN 1 ELSE 0 END) AS "WCPFC"
FROM SPECIES_RFMOS
GROUP BY "SPECIES_GROUP"
ORDER BY "SPECIES_GROUP";