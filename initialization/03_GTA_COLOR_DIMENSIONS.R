
print("Initializing color palettes for catch dimensions...")

# Define the colors for each dimension
RFMO_COL       = data.table(RFMO = c("IOTC", "ICCAT", "WCPFC", "IATTC"), FILL = pal_jco("default", alpha = 0.6)(4), OUTLINE = darken(pal_jco("default", alpha = 0.6)(4), 0.2))

GEAR_GROUP_COL = data.table(GEAR_GROUP_CODE = c("UNK", "OTHER", "BB", "PS", "LL"), FILL = pal_futurama(alpha = 0.6)(5), OUTLINE = darken(pal_futurama(alpha = 0.6)(5), 0.2))

SPECIES_COL    = data.table(SPECIES = c("BET", "SKJ", "YFT"), FILL = ggsci::pal_simpsons("springfield", alpha = 0.6)(3), OUTLINE = darken(pal_simpsons("springfield", alpha = 0.6)(3), 0.2))

print("Color palettes initialized!")