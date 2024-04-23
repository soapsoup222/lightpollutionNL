#' Create NTL Raster
#' @import dplyr
#' @import blackmarbler
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @importFrom raster mask
#' @param country country of interest
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param product_id VNP46A1, VNP46A2, VNP46A3, VNP46A4
#' @param ymd Year or Y-M-D
#' @param low_rm Remove lowest values
#' @param raster_to_points When TRUE outputs datarfame
#' @returns A raster or dataframe object for plotting
#' @export
#' @examples
#' get_NTLraster("NLD", "examplebearertoken", "VNP46A4", 2015, "FALSE")
get_NTLraster <- function(country = "NLD", bearer, product_id, ymd, low_rm = FALSE, mask = FALSE){

  roi_sf <-  gadm(country = country, level=1, path = tempdir()) |> st_as_sf()

  r <- bm_raster(roi_sf = roi_sf,
                 product_id = product_id,
                 date = as.character(ymd),
                 bearer = bearer,
                 check_all_tiles_exist = FALSE)
  if (mask == TRUE){
    r <- r |>
      mask(roi_sf)
  } else {
    return(r)
  }
  names(r) <- c("value", "x", "y")
  if (low.rm == TRUE) {
    #remove low values
    r$value[r$value <= 2] <- 0
    #log to unskew
    r$value_adj <- log(r$value+1)
    return(r)
  } else {
    #log to unskew
    r$value_adj <- log(r$value+1)
    return(r)
  }
}
