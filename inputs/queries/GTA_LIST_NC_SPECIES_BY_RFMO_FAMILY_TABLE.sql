WITH SPECIES_RFMOS AS
(
SELECT DISTINCT nc.source_authority AS "RFMO", nc.species_group AS "SPECIES_GROUP_CODE",
 sg.label AS "SPECIES_GROUP", sp.taxa_order AS "ORDER", sp.taxa_family AS "FAMILY",
 nc.species AS "SPECIES_CODE", sp.label AS "SPECIES", sp.taxa_scientific_name AS "SPECIES_SCIENTIFIC", SUM(measurement_value) AS CATCH
FROM fact_tables.global_nominal_catch_firms_level0 nc
LEFT JOIN species.species_asfis sp ON (nc.species = sp.code)
LEFT JOIN species.speciesgroup_tunaatlas sg ON (nc.species_group = sg.code)
WHERE sp.label NOT LIKE '%nei'
--AND sg.code IN ('BILLFIS', 'BONMACK', 'SCOOT', 'SPMA', 'TUNNER', 'TUNOTH', 'TUNTEMP', 'TUNTROP')
AND nc.species NOT LIKE 'FRZ'
GROUP BY nc.source_authority, nc.species_group, sg.label, sp.taxa_order, sp.taxa_family, nc.species, sp.label, sp.taxa_scientific_name
HAVING SUM(measurement_value)>3500    -- to remove errors in species reported but also removes MSP from the Mediterranean and slender tuna
ORDER BY sp.taxa_family, nc.species

)

SELECT "ORDER", "FAMILY",
SUM(CASE WHEN "RFMO" LIKE 'IATTC' THEN 1 ELSE 0 END) AS "IATTC",
SUM(CASE WHEN "RFMO" LIKE 'ICCAT' THEN 1 ELSE 0 END) AS "ICCAT",
SUM(CASE WHEN "RFMO" LIKE 'IOTC' THEN 1 ELSE 0 END) AS "IOTC",
SUM(CASE WHEN "RFMO" LIKE 'CCSBT' THEN 1 ELSE 0 END) AS "CCSBT",
SUM(CASE WHEN "RFMO" LIKE 'WCPFC' THEN 1 ELSE 0 END) AS "WCPFC"
FROM SPECIES_RFMOS
GROUP BY "ORDER", "FAMILY"
ORDER BY "ORDER", "FAMILY";