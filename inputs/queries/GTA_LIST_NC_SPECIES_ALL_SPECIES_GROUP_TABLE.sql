WITH SPECIES_ALL AS
(
  SELECT DISTINCT nc.species_group AS "SPECIES_GROUP_CODE",
  sg.label AS "SPECIES_GROUP", sp.taxa_order AS "ORDER", sp.taxa_family AS "FAMILY",
  nc.species AS "SPECIES_CODE", sp.label AS "SPECIES", sp.taxa_scientific_name AS "SPECIES_SCIENTIFIC", SUM(measurement_value) AS CATCH
  FROM fact_tables.global_nominal_catch_firms_level0 nc
  LEFT JOIN species.species_asfis sp ON (nc.species = sp.code)
  LEFT JOIN species.speciesgroup_tunaatlas sg ON (nc.species_group = sg.code)
  WHERE sp.label NOT LIKE '%nei'
  AND nc.species NOT LIKE 'FRZ'
  GROUP BY nc.species_group, sg.label, sp.taxa_order, sp.taxa_family, nc.species, sp.label, sp.taxa_scientific_name
  ORDER BY SUM(measurement_value) DESC
)

SELECT "SPECIES_GROUP", COUNT(*) AS N
FROM SPECIES_ALL
GROUP BY "SPECIES_GROUP"
ORDER BY "SPECIES_GROUP";