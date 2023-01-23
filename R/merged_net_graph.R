# Libraries
library(tidyr)
library(ggraph)
library(igraph)

# Function to use edge and vertice (species) list for visualization
## Function is for merged files, for unmerged files please use the net_graph function
merged_net_graph <- function(edge_list, species_list, compartments_list){
  
  ## Prepare data for ggraph object
  species_list <- species_list[!duplicated(species_list$ID), ] # Correct uniqueness of links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compounds", "Products")]), ] # Correct uniqueness of links in list
  
  ## Create ggraph object
  network <- graph_from_data_frame(d=edge_list, v=species_list, directed=T)
  
  ## Plot network 
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey", 
                   arrow = arrow(angle = 20, length = unit(2, "mm"), 
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(color = species_list$Location, shape = species_list$filename), size = 3) + # Color is set to Location to get a clear overview of the different reactions involved 
    scale_colour_discrete(name = "Substance location", labels = compartments_list$Name) +
    labs(shape = "Original file name") +
    geom_node_text(aes(label = species_list$Name), repel = TRUE) + 
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    theme_graph() 
}

# Try function with merged example files
merged_net_graph(merged67_edges, merged67_species, merged67_compartments) 
merged_net_graph(merged789_edges, merged789_species, merged789_compartments) 
merged_net_graph(merged678910_edges, merged678910_species, merged678910_compartments) # They all work!:)