
print("Initializing IOTC libs...")

# Load IOTC libraries
pacman::p_load("iotc.base.common.plots")

# Initialise species colors
initialize_all_species_colors()
initialize_all_gears_colors()

QUALITY_COLORS = all_quality_colors()

print("IOTC libs initialized!")

