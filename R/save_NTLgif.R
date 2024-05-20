#' Create NTL Raster masked
#' @import dplyr
#' @import blackmarbler
#' @import raster
#' @import magick
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param pathimages folder path of images to be saved as GIF
#' @param pathsave folder path to save gif
#' @returns A raster or dataframe object for plotting masked by country
#' @export
save_NTLgif <- function(pathimages, pathsave){
  NTLgif <- list.files(pathimages, full.names = TRUE) |>
    lapply(image_read) |>
    image_join() |>
    image_animate(fp = 1)

  image_write(image = NTLgif,
              path = paste0(pathsave,"/NTL.gif"))
}
