#' Create NTL Raster masked
#' @import dplyr
#' @import blackmarbler
#' @import raster
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param country country of interest
#' @param sf_mask Optional parameter, if not NULL, uses the given sf object to mask
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param product_id VNP46A1, VNP46A2, VNP46A3, VNP46A4
#' @param ymd Year or Y-M-D
#' @param output_raster When FALSE, outputs a dataframe object
#' @returns A raster or dataframe object for plotting masked by country
#' @export
#' @examples
#' get_NTLrastermasked("NLD", "examplebearertoken", "VNP46A4", 2015, "FALSE")
get_NTLrastermasked <- function(country = "NLD", sf_mask = NULL, bearer, product_id, ymd, output_raster = TRUE) {

  roi_sf <-  gadm(country = country, level=1, path = tempdir()) |> st_as_sf()

  r <- bm_raster(roi_sf = roi_sf,
                 product_id = product_id,
                 date = as.character(ymd),
                 bearer = bearer,
                 check_all_tiles_exist = FALSE)

  if (is.null(sf_mask)) {
    r <- r |> mask(roi_sf)
  } else {
    r <- r |> mask(sf_mask)
  }

  r <- r |> rasterToPoints(spatial = TRUE) |>
    as.data.frame()
  names(r) <- c("value", "x", "y")
  r$value[r$value <= 1] <- 0
  r$value_adj <- log(r$value+1)
  if (output_raster == TRUE) {
    r <- rasterFromXYZ(r,
                       crs = "WGS84")
    return(r)
  } else {
    return(r)
  }
}
