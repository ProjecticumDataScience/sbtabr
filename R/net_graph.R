# Libraries
library(ggraph)
library(tidygraph)
library(dplyr)
library(igraph)

# Function to use edge and vertice (species) list for visualisation
net_graph <- function(edge_list, species_list){

  # Prepare data if necessary
  edge_list <- separate_rows(edge_list, Compounds, sep = ", ") # Seperate duplicate values
  edge_list <- drop_na(edge_list) # Remove empty values

  species_list <- species_list[!duplicated(species_list$ID), ] # Correct unique links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compounds", "Products")]), ] # Correct unique links in list

  # Create ggraph object
  network <- graph_from_data_frame(d=edge_list, v=species_list, directed=T)

  # Plot network
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(arrow = arrow(length = unit(2, 'mm')),
                   end_cap = circle(3, 'mm')) +
    geom_node_point(aes(color = "red", size = 3), show.legend = FALSE) +
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    theme_void() # Details still under construction but it does work :)
}
