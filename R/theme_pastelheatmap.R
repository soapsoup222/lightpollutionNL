#' Add pastelheatmap theme to plot
#' @import ggplot2
#' @returns A plot object with theme applied
#' @export
#' @examples
#' plot + theme_pastelheatmap
#'
theme_pastelheatmap <- function(){
    scale_fill_gradientn(colours = c("#668ec2", "#b7deec", "#fbf8c4", "#fbb07a", "#d9534c", "#982fb5"),
                         values = c(0, 0.1, 0.2, 0.3, 0.5, 1))
}
