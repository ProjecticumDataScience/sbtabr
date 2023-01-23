# Libraries
library(tidyr)
library(ggraph)
library(igraph)

# Function to use edge and vertices (species) list for visualization
## Function is for unmerged files, for merged files please use the merged_net_graph function
net_graph <- function(edge_list, species_list, compartments_list){
  
  ## Prepare data for ggraph object
  species_list <- species_list[!duplicated(species_list$ID), ] # Correct uniqueness of links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compounds", "Products")]), ] # Correct uniqueness of links in list
  
  ## Create ggraph object
  network <- graph_from_data_frame(d=edge_list, v=species_list, directed=T)
  
  ## Plot network 
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey66", 
                   arrow = arrow(angle = 20, length = unit(2, "mm"), 
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(fill = species_list$Location), size = 3, shape = 21) + # Color is set to Location to get a clear overview of the different reactions involved 
    geom_node_text(aes(label = species_list$Name), repel = TRUE) + 
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    scale_fill_discrete(labels = compartments_list$Name, 
                        name = "Substance location") 
}

# Try function with example files
net_graph(physmap6_edges, physmap6_species, physmap6_compartments)
net_graph(physmap7_edges, physmap7_species, physmap7_compartments)
net_graph(physmap8_edges, physmap8_species, physmap8_compartments)
net_graph(physmap9_edges, physmap9_species, physmap9_compartments)