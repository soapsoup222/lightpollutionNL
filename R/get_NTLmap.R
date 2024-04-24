#' Create NTL map
#'
#' @import dplyr
#' @import ggplot2
#' @import blackmarbler
#' @importFrom geodata gadm
#' @importFrom sf st_as_sf
#' @param raster get_NTLraster raster object
#' @param maptheme Nighttime, Neonheatmap or Pastelheatmap
#' @param ymd ymd or date of map
#' @returns Map plot
#' @export
#' @examples
#'
#' get_NTLmap(NTLraster, "Nighttime", 2015)

get_NTLmap <- function(raster, maptheme = "Nighttime", ymd){
  if (maptheme == "Nighttime") {
    ggplot() +
      geom_raster(data = raster,
                  aes(x = x, y = y,
                      fill = value_adj))+
      scale_fill_gradientn(colours = c("#070e34", "#ffe605", "white"),
                           values = c(0, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1",
           title = paste0("Light Pollution in the Netherlands ", ymd),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightyellow"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightyellow"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightyellow"),
            legend.text = element_text(colour="lightyellow"),
            plot.background = element_rect(fill = "#00011d", colour = "#00011d"),
            panel.background = element_rect(fill = "#00011d", colour = "#00011d"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  }

  else if (maptheme == "Neonheatmap") {
    ggplot() +
      geom_raster(data = raster,
                  aes(x = x, y = y,
                      fill = value_adj))+
      scale_fill_gradientn(colours = c("grey5","#0d0d89","#0000ff","#00ffff", "#00b200", "#ffff00", "#d10000"),
                           values = c(0, 0.1, 0.2, 0.25, 0.3, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1",
           title = paste0("Light Pollution in the Netherlands ", ymd),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightblue"),
            legend.text = element_text(colour="lightblue"),
            plot.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            panel.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  }
  else if (maptheme == "Pastelheatmap") {
    ggplot() +
      geom_raster(data = raster,
                  aes(x = x, y = y,
                      fill = value_adj))+
      scale_fill_gradientn(colours = c("#668ec2", "#b7deec", "#fbf8c4", "#fbb07a", "#d9534c", "#982fb5"),
                           values = c(0, 0.1, 0.2, 0.3, 0.5, 1))+
      labs(fill = "Radiance/nW·cm-2·sr-1",
           title = paste0("Light Pollution in the Netherlands ", ymd),
           subtitle = "Before Darkness Areas")+
      coord_quickmap() +
      theme_void() +
      theme(plot.title = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            plot.subtitle = element_text(face = "bold", hjust = 0.5, colour = "lightblue"),
            legend.position = "bottom",
            legend.title = element_text(face = "bold",vjust = 0.5, colour="lightblue"),
            legend.text = element_text(colour="lightblue"),
            plot.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            panel.background = element_rect(fill = "#2f3132", colour = "#2f3132"),
            plot.margin = margin(0.5, 2, 0.5, 2, "cm"))
  } else {
    message("Not a valid theme. Choose from Nighttime, Neonheatmap, or Pastelheatmap")
  }
}
