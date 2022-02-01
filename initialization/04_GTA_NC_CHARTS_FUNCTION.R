
print("Initializing function for plotting charts...")

# Function to plot nominal catch charts by species, RFMO, and gear group
# Selectedspecies   = c("ALL", "BET", "SKJ", "YFT")
# dimension = c("RFMO", "GEAR_GROUP", "SPECIES")
# results saved as a list of 4 ggplots

Nominal_Catch_Charts = function(Dataset, SelectedSpecies, Dimension, Colors){
  
datafile       = if(SelectedSpecies != "ALL") Dataset[SPECIES_CODE %in% SelectedSpecies] else {datafile = Dataset}
if(Dimension == "GEAR_GROUP") SelectedColors = Colors[GEAR_GROUP_CODE %in% unique(datafile$GEAR_GROUP_CODE)] else {SelectedColors = Colors}

NC_LINEPLOT_GLOBAL_CATCH         = catch_line(datafile, color_by = Dimension, colors = SelectedColors, plot_points = TRUE) + theme(legend.position = "bottom")
NC_BARPLOT_GLOBAL_CATCH          = catch_bar(datafile, fill_by = Dimension, colors = SelectedColors) + theme(legend.position = "bottom")
NC_BARPLOT_GLOBAL_CATCH_REL      = catch_bar_rel(datafile, fill_by = Dimension, colors = SelectedColors) + theme(legend.position = "bottom")  
NC_BARPLOT_GLOBAL_CATCH_WITH_REL = ggarrange(NC_BARPLOT_GLOBAL_CATCH + theme(axis.text.x = element_text(size = 6)),
                                                NC_BARPLOT_GLOBAL_CATCH_REL + theme(axis.text.x = element_text(size = 6)),
                                                common.legend = TRUE,
                                                legend = "bottom",
                                                labels = list("a", "b"))

return(list(NC_LINEPLOT_GLOBAL_CATCH, NC_BARPLOT_GLOBAL_CATCH, NC_BARPLOT_GLOBAL_CATCH_REL, NC_BARPLOT_GLOBAL_CATCH_WITH_REL))
}

print("Chart function initialized!")