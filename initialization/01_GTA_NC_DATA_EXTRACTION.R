
print("Initializing data extraction...")

# DESCRIPTION OF CONTENTS #### 

## TIME PERIODS ####

# Nominal catches
QUERY_NC_YEAR_COVERAGE_RFMO = read_file("../inputs/queries/GTA_YEAR_COVERAGE_NC_RFMO.sql")
NC_YEAR_COVERAGE_RFMO       = dbGetQuery(con_GTA, QUERY_NC_YEAR_COVERAGE_RFMO)

## FISHING GEARS ####


## SPECIES ####

# Full list of species for all RFMOs with catch
# No filter on catch
QUERY_NC_SPECIES_LIST_GLOBAL = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_ALL.sql")
NC_SPECIES_LIST_GLOBAL = as.data.table(dbGetQuery(con_GTA, QUERY_NC_SPECIES_LIST_GLOBAL))

# Total number of species by species group
# No filter on catch
QUERY_GTA_LIST_NC_SPECIES_GLOBAL_SPECIES_GROUP_TABLE = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_ALL_SPECIES_GROUP_TABLE.sql")
NC_SPECIES_NUMBERS_BY_SPECIES_GROUP_GLOBAL_TABLE = as.data.table(dbGetQuery(con_GTA, QUERY_GTA_LIST_NC_SPECIES_GLOBAL_SPECIES_GROUP_TABLE))

# Total number of species by family
# No filter on catch
QUERY_GTA_LIST_NC_SPECIES_GLOBAL_FAMILY_TABLE = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_ALL_FAMILY_TABLE.sql")
NC_SPECIES_NUMBERS_BY_FAMILY_GLOBAL_TABLE = as.data.table(dbGetQuery(con_GTA, QUERY_GTA_LIST_NC_SPECIES_GLOBAL_FAMILY_TABLE))

# Full list of species by RFMO
# No filter
QUERY_NC_SPECIES_LIST_RFMO = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_BY_RFMO.sql")
NC_SPECIES_LIST_RFMO = as.data.table(dbGetQuery(con_GTA, QUERY_NC_SPECIES_LIST_RFMO))

# Table by species group
# Trick in the query to removes the errors of reporting of species with a catch threshold
# CAUTION: the threshold will remove rare species, including slender tuna and Mediterannean spearfish from the data set
QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE.sql")
NC_SPECIES_NUMBERS_BY_SPECIES_GROUP_RFMO_TABLE = as.data.table(dbGetQuery(con_GTA, QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE))

# Table by family
# Trick in the query to removes the errors of reporting of species with a catch threshold
# CAUTION: the threshold will remove rare species, including slender tuna and Mediterannean spearfish from the data set
QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_FAMILY_TABLE = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_BY_RFMO_FAMILY_TABLE.sql")
NC_SPECIES_NUMBERS_BY_FAMILY_RFMO_TABLE = as.data.table(dbGetQuery(con_GTA, QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_FAMILY_TABLE))

# ALL SPECIES ####
NC_ALL = as.data.table(dbGetQuery(con_GTA, "SELECT * FROM fact_tables.global_nominal_catch_firms_level0;"))

# TROPICAL TUNAS ####

# Extract Nominal Catch data from the GTA database
NC_YEAR_RFMO_GEAR_GROUP_SPECIES = as.data.table(dbGetQuery(con_GTA,
"SELECT DISTINCT year AS \"YEAR\", source_authority AS \"RFMO\", gear_group AS \"GEAR_GROUP_CODE\", species AS \"SPECIES_CODE\", sum(value) AS \"CATCH\"
FROM fact_tables.global_nominal_catch_firms_level0
WHERE species IN ('BET', 'SKJ', 'YFT')
AND year>1949
GROUP BY year, source_authority, gear_group, species
ORDER BY year, source_authority, gear_group, species;"
))

# Add gear groups
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "UNK", GEAR_GROUP := "Unknown"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "OTHER", GEAR_GROUP := "Other"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "BB", GEAR_GROUP := "Pole and line"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "PS", GEAR_GROUP := "Purse seine"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "LL", GEAR_GROUP := "Longline"]
                                
# Factorize gear groups
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[, GEAR_GROUP_CODE := factor(GEAR_GROUP_CODE, levels = c("UNK", "OTHER", "BB", "PS", "LL"))]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[, GEAR_GROUP      := factor(GEAR_GROUP, levels = c("Unknown", "Other", "Pole and line", "Purse seine", "Longline"))]

print("Data extracted!")
