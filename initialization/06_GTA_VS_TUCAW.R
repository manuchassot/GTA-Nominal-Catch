
print("Initializing comparison of GTA with TUCAW...")

# TUCAW DATASET ####
ao  = data.table(read.xlsx("../inputs/data/TUCAW/taskiengATL5020.xlsx", sheet = "taskieng"))[espece != "c", -c("Total")][, RFMO := "ICCAT"]
epo = data.table(read.xlsx("../inputs/data/TUCAW/taskiengEPO5020.xlsx", sheet = "taskieng"))[espece != "c", -c("Total")][, RFMO := "IATTC"]
io = data.table(read.xlsx("../inputs/data/TUCAW/taskiengIO5020.xlsx", sheet = "taskieng"))[espece != "c", -c("Total")][, RFMO := "IOTC"]
wcpo = data.table(read.xlsx("../inputs/data/TUCAW/taskiengWPO5020.xlsx", sheet = "taskieng"))[espece != "all", -c("Total")][, RFMO := "WCPFC"]

TUCAW_TABLE = rbindlist(list(ao, epo, io, wcpo))
colnames(TUCAW_TABLE) = c("SPECIES_CODE", "YEAR", "PS", "BB", "OTHER", "LL", "RFMO")
TUCAW       = melt.data.table(TUCAW_TABLE, id.vars = c("YEAR", "RFMO", "SPECIES_CODE"), variable.name = "GEAR_GROUP_CODE", value.name = "CATCH")[CATCH>0]

# Add gear groups
TUCAW[GEAR_GROUP_CODE == "OTHER", GEAR_GROUP := "Other"]
TUCAW[GEAR_GROUP_CODE == "BB", GEAR_GROUP := "Pole and line"]
TUCAW[GEAR_GROUP_CODE == "PS", GEAR_GROUP := "Purse seine"]
TUCAW[GEAR_GROUP_CODE == "LL", GEAR_GROUP := "Longline"]

# Add source
TUCAW[, SOURCE := "TUCAW"]

# GLOBAL TUNA ATLAS DATASET ####
GTA = NC_YEAR_RFMO_GEAR_GROUP_SPECIES[GEAR_GROUP_CODE == "UNK", `:=` (GEAR_GROUP_CODE = 'OTHER', GEAR_GROUP = "Other")][, .(CATCH = sum(CATCH)), keyby = .(YEAR, RFMO, GEAR_GROUP_CODE, GEAR_GROUP, SPECIES_CODE)][, SOURCE := "GTA"]

NC = rbindlist(list(GTA, TUCAW), use.names = TRUE)

NC_YEAR_RFMO_SOURCE = NC[YEAR < 2020 & SPECIES_CODE %in% c("BET", "SKJ", "YFT"), .(CATCH = sum(CATCH)), keyby = .(YEAR, RFMO, SOURCE)]

NC_YEAR_RFMO_SOURCE_LINEPLOT = 
  ggplot(data = NC_YEAR_RFMO_SOURCE, aes(x = YEAR, y = CATCH/1000)) +
  geom_line(mapping = aes(color = SOURCE), size = 1.1) +
  facet_wrap(~RFMO, scales = "free_y") +
  labs(x = "") +
  labs(y = "Total catch (x1,000 t)") +
  theme_bw() +
  theme(legend.position = "bottom", legend.title = element_blank(), strip.background =element_rect(fill="white"), strip.text = element_text(size = 14))

save_plot("../outputs/charts/NC_YEAR_RFMO_SOURCE_LINEPLOT.png", NC_YEAR_RFMO_SOURCE_LINEPLOT, 8, 5)

print("Comparion of GTA vs. TUCAW initialized!")


