# Libraries
library(tidyr)
library(ggraph)
library(igraph)

# Function to use edge and vertices (species) list for visualization
## Function is for unmerged files, for merged files please use the merged_net_graph function
#' Title
#'
#' @param edge_list A list for the lines between nodes
#' @param species_list A list with the nodes
#'
#' @return A graph with the nodes species_list connected by lines from edge_list
#' @export
#'
#' @examples
#' net_graph(physmap8_edges, physmap8_species)
#'
#' net_graph(physmap9_edges, physmap9_species)

net_graph <- function(edge_list, species_list){

  ## Create ggraph object
  network <- graph_from_data_frame(d=edge_list, v=species_list, directed=T)

  ## Plot network
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey66",
                   arrow = arrow(angle = 20, length = unit(2, "mm"),
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(fill = species_list$Name, size = 3), shape = 21) + # Color is set to Name to get a clear overview of the different substances involved
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    theme_graph() +
    theme(legend.position = "none") # Details of graph are still under construction
}



