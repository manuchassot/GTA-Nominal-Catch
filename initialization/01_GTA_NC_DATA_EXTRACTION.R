
print("Initializing data extraction...")

# TEMPORARY FIX ####

# Missing catch for IATTC in 2019
# https://www.iattc.org/PublicDomainData/CatchByFlagGear.zip
NC_IATTC_2019 = fread("../inputs/data/CatchFlagGear1918-2019.csv")[AnoYear == 2019]

# Format gear groups
NC_IATTC_2019[ArteGear %in% c('OTR', 'GN', 'LTL', 'RG'), ArteGear := "OTHER"]
NC_IATTC_2019[ArteGear == 'NK',                          ArteGear := "UNK"]

# DESCRIPTION OF CONTENTS #### 

## TIME PERIODS ####




## SPECIES ####

QUERY_NC_SPECIES_LIST_RFMO = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_BY_RFMO.sql")
NC_SPECIES_LIST_RFMO = as.data.table(dbGetQuery(con_GTA, QUERY_NC_SPECIES_LIST_RFMO))

# Temp: save lists for ICCAT to check
write.xlsx(NC_SPECIES_LIST_RFMO[RFMO == "ICCAT" & SPECIES_GROUP %in% c("Temperate tunas", "Tropical tunas", "Neritic tunas", "Billfishes"), .(ORDER, FAMILY, SPECIES_CODE, SPECIES, SPECIES_SCIENTIFIC)], file = "../inputs/data/ICCAT_SPECIES_LIST_TUNA_BILLFISH.xlsx")


# Table by species group
QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE = read_file("../inputs/queries/GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE.sql")
NC_SPECIES_NUMBERS_BY_SPECIES_GROUP_RFMO_TABLE = as.data.table(dbGetQuery(con_GTA, QUERY_GTA_LIST_NC_SPECIES_BY_RFMO_SPECIES_GROUP_TABLE))



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

NC_YEAR_RFMO_GEAR_GROUP_SPECIES_IATTC_2019 = NC_IATTC_2019[EspeciesSpecies %in% c("BET", "SKJ", "YFT"), .(RFMO = "IATTC", CATCH = sum(t, na.rm = T)), keyby = .(YEAR = AnoYear, GEAR_GROUP_CODE = ArteGear, SPECIES_CODE = EspeciesSpecies)]

# Trick to add "fake" catch of BET in 1950-1953 to clean the charts
NC_YEAR_RFMO_GEAR_GROUP_SPECIES_IATTC_1950_1953 = data.table(YEAR = 1950:1953, RFMO = "IATTC", GEAR_GROUP_CODE = "LL", SPECIES_CODE = "BET", CATCH = 0)

NC_YEAR_RFMO_GEAR_GROUP_SPECIES = rbindlist(list(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, NC_YEAR_RFMO_GEAR_GROUP_SPECIES_IATTC_2019, NC_YEAR_RFMO_GEAR_GROUP_SPECIES_IATTC_1950_1953), use.names = TRUE)

# Add gear groups
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "UNK", GEAR_GROUP := "Unknown"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "OTHER", GEAR_GROUP := "Other"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "BB", GEAR_GROUP := "Pole and line"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "PS", GEAR_GROUP := "Purse seine"]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "LL", GEAR_GROUP := "Longline"]
                                
# Factorize gear groups
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[, GEAR_GROUP_CODE := factor(GEAR_GROUP_CODE, levels = c("UNK", "OTHER", "BB", "PS", "LL"))]
NC_YEAR_RFMO_GEAR_GROUP_SPECIES[, GEAR_GROUP      := factor(GEAR_GROUP, levels = c("Unknown", "Other", "Pole and line", "Purse seine", "Longline"))]

# TEMP
# Correct ICCAT data by dividing the catches by 2
# NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "ICCAT", CATCH := CATCH/2]

print("Data extracted!")