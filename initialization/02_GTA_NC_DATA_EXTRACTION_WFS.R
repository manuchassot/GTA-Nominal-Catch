
# Dataset PID
pid   = "global_nominal_catch_firms_level0"
layer = "global_nominal_catch_firms_level0"

# Connect to OGC WFS to get DATA
WFS = WFSClient$new(
  url = "https://www.fao.org/fishery/geoserver/gta/ows",
  serviceVersion = "1.0.0",
  logger = "INFO"
)

# Get feature type for dataset 'global_nominal_catch_firms_level0' (layer = 'global_nominal_catch_firms_level0' )
ft = WFS$capabilities$findFeatureTypeByName(layer)

# Get aggregated data features for dataset 'global_nominal_catch_firms_level0' (layer = 'global_nominal_catch_firms_level0' )
# Last line: you can get the features as displayed in the map (aggregated)
data.sf <- ft$getFeatures(viewparams = "source_authority:IATTC;month:1;quarter:1;year:2019;unit:MT;aggregation_method:sum")

# Get raw data
rawdata.sf <- ft$getFeatures(viewparams = "source_authority:IATTC;month:1;quarter:1;year:2019;unit:MT;aggregation_method:none")


NC_YEAR_RFMO_GEAR_GROUP_SPECIES