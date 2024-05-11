#' Add neonheatmap theme to plot
#' @import ggplot2
#' @param plot a ggplot object
#' @returns A plot object with theme applied
#' @export
#' @examples
#' plot + theme_neonheatmap
#'
theme_neonheatmap <- function(plot){
    scale_fill_gradientn(colours = c("grey5","#0d0d89","#0000ff","#00ffff", "#00b200", "#ffff00", "#d10000"),
                         values = c(0, 0.1, 0.2, 0.25, 0.3, 0.5, 1))+
    theme_void()
}
