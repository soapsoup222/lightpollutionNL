#' Create NTL Raster masked
#' @import dplyr
#' @import blackmarbler
#' @import raster
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param country country of interest
#' @param product_id VNP46A1, VNP46A2, VNP46A3, VNP46A4
#' @param sf_mask Optional parameter, if not NULL, uses the given sf object to mask
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param ymd Year or Y-M-D
#' @param output_raster When FALSE, outputs a dataframe object
#' @returns A raster or dataframe object for plotting masked by country
#' @export
#' @examples
#' get_NTLrastermasked("NLD", "examplebearertoken", "VNP46A4", 2015, "FALSE")
save_NTLimages <- function(country = "NLD",
                           product_id = "VNP46A4",
                           years,
                           low.rm = FALSE,
                           mask = FALSE,
                           maptheme = "Nighttime",
                           folderpath){
  for (y in years) {
    year <- as.character(y)
    raster <- get_NTLraster(country = "NLD", product_id = "VNP46A4", ymd = year )

    NTLplot <- get_NTLmap(raster = raster, maptheme = maptheme, year = year)


    fp <- file.path(folderpath, paste0(y, ".png"))

    ggsave(plot = NTLplot,
           filename = fp,
           device = "png")
  }

  NTLgif <- list.files(folderpath, full.names = TRUE) |>
    lapply(image_read) |>
    image_join() |>
    image_animate(fp = 1)

  image_write(image = NTLgif,
              path = paste0(folderpath,"/NTL.gif"))
}
