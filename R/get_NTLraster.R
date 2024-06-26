#' Create NTL Raster with necessary transformations
#' @import dplyr
#' @import blackmarbler
#' @import raster
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param country country of interest
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param product_id VNP46A1 (Raw Daily), VNP46A2 (Adjusted Daily), VNP46A3(Monthly), VNP46A4(Yearly)
#' @param ymd Year or Y-M-D
#' @returns A raster object for plotting
#' @export
#' @examples
#' get_NTLraster("NLD", "examplebearertoken", "VNP46A4", 2015, "FALSE")
#'
get_NTLraster <- function(country = "NLD", bearer, product_id = "VNP46A4", ymd) {

  roi_sf <-  gadm(country = country, level=1, path = tempdir()) |> st_as_sf()
  r <- bm_raster(roi_sf = roi_sf,
                 product_id = product_id,
                 date = as.character(ymd),
                 bearer = bearer,
                 check_all_tiles_exist = FALSE)
  r <- reclassify(r, matrix(c(0, 1, 0)), right = TRUE)
  r <- log10(r+1)
}
