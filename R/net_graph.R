# Libraries
library(ggraph)
library(tidygraph)
library(dplyr)
library(igraph)

# Function to use edge and vertice (species) list for visualisation
net_graph <- function(edge_list, species_list){

  ## Prepare data if necessary
  edge_list <- separate_rows(edge_list, Compounds, sep = ", ") # Separate duplicate values
  edge_list <- drop_na(edge_list) # Remove empty values

  species_list <- species_list[!duplicated(species_list$ID), ] # Correct unique links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compounds", "Products")]), ] # Correct unique links in list

  ## Create ggraph object
  network <- graph_from_data_frame(d=edge_list, v=species_list, directed=T)

  ## Plot network
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey66",
                   arrow = arrow(angle = 20, length = unit(2, "mm"),
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(fill = species_list$Name, size = 3), shape = 21) + # When merged, change $Name to $filename
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    theme_graph() +
    theme(legend.position = "none") # Details of graph are still under construction
}

# Try function with example files
## Because these files aren't merged yet, the node fill is set to Name, to show what will happen
## The function does also work with merged files
net_graph(physmap6_edges, physmap6_species)
net_graph(physmap7_edges, physmap7_species)
net_graph(physmap8_edges, physmap8_species)
net_graph(physmap9_edges, physmap9_species)
net_graph(physmap10_edges, physmap10_species) # They all work!:)
