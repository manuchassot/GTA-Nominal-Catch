# Source the R codes
setwd("initialization")
source("00_CORE.R")
setwd("..")

TITLE = "GlobalTunaAtlas_TropicalTuna_Nominal_Catch"

options(scipen = 100)

# HTML
render("rmd/00_HTML.Rmd", 
        output_dir    = "outputs/", 
        output_file   = paste0(TITLE, ".html")
)

