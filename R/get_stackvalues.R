#' Convert rasterstack object into df of values
#' @import dplyr
#' @import raster
#' @param rasterstack a rasterstack or rasterlayer object
#' @returns A dataframe with each layer and its values
#' @export
#' @examples
#' get_NTLraster(rasterstack)
#'
get_stackvalues <- function(rasterstack) {
  # Initialize an empty dataframe
  num_rows <- nrow(rasterToPoints(rasterstack[[1]]))
  df <- data.frame(matrix(nrow = num_rows, ncol = 0))

  # Iterate through each layer in the raster stack
  for (i in 1:nlayers(rasterstack)) {
    # Convert the current layer to points
    rasterpoints <- rasterstack[[i]] |> rasterToPoints()
    rasterpointscol <- rasterpoints[,3]
    # Add the points as a new column to the dataframe
    # Ensure the column name is unique and descriptive
    colname <- paste0("Layer_", i)
    df[[colname]] <- rasterpointscol
  }

  # Return the updated dataframe
  return(df)
}
