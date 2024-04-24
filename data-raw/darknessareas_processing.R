library(dplyr)
library(sf)

darknessareas_df <- read.csv("data-raw/darkness_areas_zeeland.csv") |>
  mutate(description = NULL)

darknessareas_sf <- st_as_sf(darknessareas_csv, wkt = "WKT", crs = "WSG84")

usethis::use_data(darknessareas_df,
                  darknessareas_sf,
                  overwrite = T)
