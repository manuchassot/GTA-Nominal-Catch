
SELECT DISTINCT nc.gear AS "GEAR_CODE", g.label AS "GEAR", SUM(nc.value) AS "CATCH"
FROM fact_tables.global_nominal_catch_firms_level0 nc
LEFT JOIN gear.isscfg_revision_1 g ON (nc.gear = code)
GROUP BY nc.gear, g.label
ORDER BY sum(nc.value) DESC

SELECT DISTINCT gc.gear AS "GEAR_CODE", g.label AS "GEAR", SUM(gc.value) AS "CATCH"
FROM fact_tables.global_catch_firms_level0 gc
LEFT JOIN gear.isscfg_revision_1 g ON (nc.gear = code)
GROUP BY gc.gear, g.label
ORDER BY sum(gc.value) DESC

SELECT DISTINCT source_authority, gc.gear AS "GEAR_CODE", g.label AS "GEAR",
COUNT(DISTINCT (geographic_identifier)) AS N_AREAS,
SUM(gc.value) AS "CATCH"
FROM fact_tables.global_catch_firms_level0 gc
LEFT JOIN gear.isscfg_revision_1 g ON (gc.gear = code)
GROUP BY  source_authority,gc.gear, g.label
ORDER BY  source_authority, sum(gc.value) DESC