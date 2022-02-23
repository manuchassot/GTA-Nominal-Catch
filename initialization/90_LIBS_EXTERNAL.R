
print("Initialization of external libraries...")

# Install/load pacman
if(!require(pacman)){
  install.packages("pacman")
  suppressPackageStartupMessages(library(pacman,quietly = TRUE))
}

# Install/load libraries required for analysis
p_load(
  "tidyverse",
  "flextable",
  "scales",
  "openxlsx",
  "ggpubr",
  "gridExtra",
  "rmarkdown",
  "knitr",
  "bookdown",
  "officer",
  "dplyr",
  "ggsci",
  "RPostgreSQL",
  "data.table",
  "DT",
  "plotly",
  "ows4R",
  "ritis"
  )

print("External libraries initialized!")