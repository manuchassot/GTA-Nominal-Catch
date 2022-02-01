
print("Initializing charts of catch time series...")

# Nominal catch by species for each RFMO ####
NC_ALL_RFMO = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "ALL", "RFMO", RFMO_COL)
NC_BET_RFMO = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "BET", "RFMO", RFMO_COL)
NC_SKJ_RFMO = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "SKJ", "RFMO", RFMO_COL)
NC_YFT_RFMO = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "YFT", "RFMO", RFMO_COL)

# Nominal catch by species for each gear group ####
NC_ALL_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "ALL", "GEAR_GROUP", GEAR_GROUP_COL)
NC_BET_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "BET", "GEAR_GROUP", GEAR_GROUP_COL)
NC_SKJ_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "SKJ", "GEAR_GROUP", GEAR_GROUP_COL)
NC_YFT_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "YFT", "GEAR_GROUP", GEAR_GROUP_COL)

# Nominal catch by species ####
NC_ALL_SPECIES = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES, "ALL", "SPECIES_CODE", SPECIES_COL)

# Nominal catch of bigeye tuna (BET) by gear group for each RFMO ####
NC_BET_ICCAT_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "ICCAT"], "BET", "GEAR_GROUP", GEAR_GROUP_COL)
NC_BET_IATTC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IATTC"], "BET", "GEAR_GROUP", GEAR_GROUP_COL)
NC_BET_IOTC_GEAR_GROUP  = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IOTC"],  "BET", "GEAR_GROUP", GEAR_GROUP_COL)
NC_BET_WCPFC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "WCPFC"], "BET", "GEAR_GROUP", GEAR_GROUP_COL)

NC_BARPLOT_GEAR_GROUP_RFMO_BET = 
  ggarrange(NC_BET_WCPFC_GEAR_GROUP[[2]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_BET_IATTC_GEAR_GROUP[[2]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_BET_ICCAT_GEAR_GROUP[[2]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_BET_IOTC_GEAR_GROUP[[2]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

NC_LINEPLOT_GEAR_GROUP_RFMO_BET = 
  ggarrange(NC_BET_WCPFC_GEAR_GROUP[[1]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_BET_IATTC_GEAR_GROUP[[1]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_BET_ICCAT_GEAR_GROUP[[1]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_BET_IOTC_GEAR_GROUP[[1]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

save_plot("../outputs/charts/NC_BARPLOT_GEAR_GROUP_RFMO_BET.png", NC_BARPLOT_GEAR_GROUP_RFMO_BET, 16, 9)
save_plot("../outputs/charts/NC_LINEPLOT_GEAR_GROUP_RFMO_BET.png", NC_LINEPLOT_GEAR_GROUP_RFMO_BET, 16, 9)

# Nominal catch of skipjack tuna (SKJ) by gear group for each RFMO ####
NC_SKJ_ICCAT_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "ICCAT"], "SKJ", "GEAR_GROUP", GEAR_GROUP_COL)
NC_SKJ_IATTC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IATTC"], "SKJ", "GEAR_GROUP", GEAR_GROUP_COL)
NC_SKJ_IOTC_GEAR_GROUP  = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IOTC"],  "SKJ", "GEAR_GROUP", GEAR_GROUP_COL)
NC_SKJ_WCPFC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "WCPFC"], "SKJ", "GEAR_GROUP", GEAR_GROUP_COL)

NC_BARPLOT_GEAR_GROUP_RFMO_SKJ = 
  ggarrange(NC_SKJ_WCPFC_GEAR_GROUP[[2]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_SKJ_IATTC_GEAR_GROUP[[2]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_SKJ_ICCAT_GEAR_GROUP[[2]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_SKJ_IOTC_GEAR_GROUP[[2]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

NC_LINEPLOT_GEAR_GROUP_RFMO_SKJ = 
  ggarrange(NC_SKJ_WCPFC_GEAR_GROUP[[1]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_SKJ_IATTC_GEAR_GROUP[[1]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_SKJ_ICCAT_GEAR_GROUP[[1]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_SKJ_IOTC_GEAR_GROUP[[1]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

save_plot("../outputs/charts/NC_BARPLOT_GEAR_GROUP_RFMO_SKJ.png", NC_BARPLOT_GEAR_GROUP_RFMO_SKJ, 16, 9)
save_plot("../outputs/charts/NC_LINEPLOT_GEAR_GROUP_RFMO_SKJ.png", NC_LINEPLOT_GEAR_GROUP_RFMO_SKJ, 16, 9)

# Nominal catch of yellowfin tuna (YFT) by gear group for each RFMO ####
NC_YFT_ICCAT_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "ICCAT"], "YFT", "GEAR_GROUP", GEAR_GROUP_COL)
NC_YFT_IATTC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IATTC"], "YFT", "GEAR_GROUP", GEAR_GROUP_COL)
NC_YFT_IOTC_GEAR_GROUP  = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "IOTC"],  "YFT", "GEAR_GROUP", GEAR_GROUP_COL)
NC_YFT_WCPFC_GEAR_GROUP = Nominal_Catch_Charts(NC_YEAR_RFMO_GEAR_GROUP_SPECIES[RFMO == "WCPFC"], "YFT", "GEAR_GROUP", GEAR_GROUP_COL)

NC_BARPLOT_GEAR_GROUP_RFMO_YFT = 
  ggarrange(NC_YFT_WCPFC_GEAR_GROUP[[2]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_YFT_IATTC_GEAR_GROUP[[2]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_YFT_ICCAT_GEAR_GROUP[[2]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_YFT_IOTC_GEAR_GROUP[[2]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

NC_LINEPLOT_GEAR_GROUP_RFMO_YFT = 
  ggarrange(NC_YFT_WCPFC_GEAR_GROUP[[1]] + labs(title = "Western-Central Pacific Fisheries Commission"), 
            NC_YFT_IATTC_GEAR_GROUP[[1]] + labs(title = "Inter-American Tropical Tuna Commission"),
            NC_YFT_ICCAT_GEAR_GROUP[[1]] + labs(title = "International Commission for the Conservation of Atlantic Tunas"),
            NC_YFT_IOTC_GEAR_GROUP[[1]] + labs(title = "Indian Ocean Tuna Commission"),
            legend = "bottom",
            common.legend = TRUE)

save_plot("../outputs/charts/NC_BARPLOT_GEAR_GROUP_RFMO_YFT.png", NC_BARPLOT_GEAR_GROUP_RFMO_YFT, 16, 9)
save_plot("../outputs/charts/NC_LINEPLOT_GEAR_GROUP_RFMO_YFT.png", NC_LINEPLOT_GEAR_GROUP_RFMO_YFT, 16, 9)

print("Charts of catch time series initialized!")
