#' Create NTL dataframe
#'
#' @param country country of interest
#' @param bearer Your personal bearer token from NASA Earthdata
#' @param product_id VNP46A1, VNP46A2, VNP46A3, VNP46A4
#' @param ymd Year or Y-M-D
#' @param low_rm Remove lowest values
#' @param tidy when TRUE, outputs a tidied dataframe
#' @returns A dataframe object containing NTL values and coordinates
#' @export
#' @examples
#' get_NTLraster("NLD", "VNP46A4", 2015, "examplebearertoken", "FALSE")
get_NTLdf <- function(country, bearer, product_id = "VNP46A4", ymd,  tidy=TRUE){
  roi_sf <-  gadm(country = country, level=1, path = tempdir()) |> st_as_sf()
  df <- bm_extract(roi_sf = roi_sf,
                   product_id = product_id,
                   date = ymd,
                   bearer = bearer)
}
