#' Create NTL Raster masked
#' @import dplyr
#' @import blackmarbler
#' @import raster
#' @import ggplot2
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param country country of interest
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param product_id VNP46A1, VNP46A2, VNP46A3, VNP46A4
#' @param years Vector of years
#' @param maptheme "Nighttime" "NeonHeatMap" or "PastelHeatMap"
#' @returns A raster or dataframe object for plotting masked by country
#' @export
#' @examples
#' get_NTLrastermasked("NLD", "examplebearertoken", "VNP46A4", 2015, "FALSE")
save_NTLimages <- function(country = "NLD", bearer, product_id = "VNP46A4", years,
                           maptheme = "PastelHeatMap", folderpath){
  for (y in years) {
    year <- as.character(y)
    raster <- get_NTLspatdf(country = "NLD", product_id = "VNP46A4", ymd = year )
    if (maptheme == "PastelHeatMap") {
      NTLplot <- get_NTLmap(raster = raster, maptheme = maptheme, year = year) +
        theme_pastelheatmap()
    } else if (maptheme == "Nighttime") {
      NTLplot <- get_NTLmap(raster = raster, maptheme = maptheme, year = year) +
        theme_nighttime()
    } else if (maptheme == "NeonHeatMap") {
      NTLplot <- get_NTLmap(raster = raster, maptheme = maptheme, year = year) +
        theme_neonheatmap()
    } else {warning("Please input map theme")}


    fp <- file.path(folderpath, paste0(y, ".png"))

    ggsave(plot = NTLplot,
           filename = fp,
           device = "png")
  }
}
