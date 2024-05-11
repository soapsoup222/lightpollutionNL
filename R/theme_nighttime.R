#' Add nighttime theme to plot
#' @import ggplot2
#' @returns A plot object with theme applied
#' @export
#' @examples
#' plot + theme_nighttime
#'
theme_nighttime <- function(){
    scale_fill_gradientn(colours = c("#070e34", "#ffe605", "white"),
                         values = c(0, 0.5, 1))+
    theme_void()
}
