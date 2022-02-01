# Clears the environment
rm(list = ls())

# Includes defaults and helper functions
source("./00_LIBS_EXTERNAL.R")
source("./00_LIBS_IOTC.R")

# Core charts and tables
source("./01_DATABASE_CONNECTIONS.R")
source("./02_GTA_NC_DATA_EXTRACTION.R")
source("./03_GTA_COLOR_DIMENSIONS.R")
source("./04_GTA_NC_CHARTS_FUNCTION.R")
source("./05_GTA_NC_CHARTS.R")
source("./06_GTA_VS_TUCAW.R")
