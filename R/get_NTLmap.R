#' Create NTL map to use in combination with themes
#'
#' @import dplyr
#' @import ggplot2
#' @import blackmarbler
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param spatialdf spatial dataframe object from get_spatdf
#' @param ymd ymd or date of map
#' @returns Map plot
#' @export
#' @examples
#'
#' get_NTLmap(NTLraster, 2015)

get_NTLmap <- function(raster, ymd){
    ggplot() +
      geom_raster(data = raster,
                  aes(x = x, y = y,
                      fill = value))+
      labs(fill = "Radiance/nW·cm-2·sr-1",
           title = paste0("Light Pollution in the Netherlands ", ymd))+
      coord_sf(crs = "WSG84") +
      theme_void()
}

