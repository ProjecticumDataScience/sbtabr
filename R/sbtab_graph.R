
# Try using example SBtab (physmap6) to make graph. SBtab to object is already done in SBtab_to_dfs.R
## Turn into igraph object

nrow(physmap6_species); length(unique(physmap6_species$ID))
nrow(physmap6_edges); nrow(unique(physmap6_edges[,c("Compounds", "Products")])) # Returns more links than unique from-to  combinations, means multiple links between the same two nodes

physmap6_species <- physmap6_species[4:nrow(physmap6_species),] # Correction of problem above

net_physmap6 <- graph_from_data_frame(d=physmap6_edges, vertices=physmap6_species, directed=T) # D = edges of network: ID's of source and target nodes, vertices = column of node IDs: other columns are attributes
class(net_physmap6)
net_physmap6

E(net_physmap6)       # View the edges of the "net" object
V(net_physmap6)       # View the vertices of the "net" object

## Plot

plot(net_physmap6, edge.arrow.size=.4, vertex.color="red", vertex.size=20,
     vertex.frame.color="black", vertex.label.color="black", vertex.label.cex=1,
     vertex.label.dist=0) # Plot network




# Try using example SBtab (physmap7) to make graph. SBtab to object is already done in SBtab_to_dfs.R
## Turn into igraph object

nrow(physmap7_species); length(unique(physmap7_species$ID)) # 14 and 11, needs correcting
nrow(physmap7_edges); nrow(unique(physmap7_edges[,c("Compounds", "Products")])) # Both 16, no correction needed

physmap7_species <- physmap7_species[4:nrow(physmap7_species),] # Correction of problem above

net_physmap7 <- graph_from_data_frame(d=physmap7_edges, vertices=physmap7_species, directed=T) # D = edges of network: ID's of source and target nodes, vertices = column of node IDs: other columns are attributes
class(net_physmap7)
net_physmap7

E(net_physmap7)       # View the edges of the "net" object
V(net_physmap7)       # View the vertices of the "net" object

## Plot

plot(net_physmap7, edge.arrow.size=.4, vertex.color="lightblue", vertex.size=20,
     vertex.frame.color="black", vertex.label.color="black", vertex.label.cex=1,
     vertex.label.dist=0) # Plot network





# Try using physmap8

nrow(physmap8_species); length(unique(physmap8_species$ID)) # 63 and 48, needs correcting
nrow(physmap8_edges); nrow(unique(physmap8_edges[,c("Compounds", "Products")])) # 64 and 62, needs correcting

physmap8_species <- physmap8_species[4:nrow(physmap8_species),] # Previous used correction isn't working

net_physmap8 <- graph_from_data_frame(d=physmap8_edges, vertices=physmap8_species, directed=T) # D = edges of network: ID's of source and target nodes, vertices = column of node IDs: other columns are attributes

# Try to come up with a correction that works for every file

physmap8_species <- physmap8_species[!duplicated(physmap8_species$ID), ] # This fixes the links (via dplyr)
nrow(physmap8_species); length(unique(physmap8_species$ID)) # Check

physmap8_edges <- physmap8_edges[!duplicated(physmap8_edges[,c("Compounds", "Products")]), ] # This also fixes the links
nrow(physmap8_edges); nrow(unique(physmap8_edges[,c("Compounds", "Products")])) # Check



# This for some reason does not work
net_physmap8 <- graph_from_data_frame(d=physmap8_edges, v=physmap8_species, directed=T) # D = edges of network: ID's of source and target nodes, vertices = column of node IDs: other columns are attributes
# Error = Some vertex names in edge list are not listed in vertex data frame
## Help?:(

# Try alternatives to fix the error above:

# Obtaining igraph object only from edgelist
test6 <- graph_from_edgelist(physmap6_edges, directed = TRUE)
# Error = expects a matrix with two columns
## There are three columns, maybe get rid of one column > which one???
