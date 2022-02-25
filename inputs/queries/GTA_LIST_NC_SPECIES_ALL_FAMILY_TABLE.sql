WITH SPECIES_ALL AS
(
  SELECT DISTINCT nc.species_group AS "SPECIES_GROUP_CODE",
  sg.label AS "SPECIES_GROUP", sp.order_ AS "ORDER", sp.family AS "FAMILY",
  nc.species AS "SPECIES_CODE", sp.label AS "SPECIES", sp.scientific_name AS "SPECIES_SCIENTIFIC", SUM(value) AS CATCH
  FROM fact_tables.global_nominal_catch_firms_level0 nc
  LEFT JOIN species.species_asfis sp ON (nc.species = sp.code)
  LEFT JOIN species.speciesgroup_tunaatlas sg ON (nc.species_group = sg.code)
  WHERE sp.label NOT LIKE '%nei'
  AND nc.species NOT LIKE 'FRZ'
  GROUP BY nc.species_group, sg.label, sp.order_, sp.family, nc.species, sp.label, sp.scientific_name
  ORDER BY SUM(value) DESC
)

SELECT "ORDER", "FAMILY", COUNT(*) AS N
FROM SPECIES_ALL
GROUP BY "ORDER", "FAMILY"
ORDER BY "ORDER", "FAMILY";