#' Visualize a SBtab file made with sep_sbtab
#'
#' @param edge_file the output file from the sep_sbtab function or an existing edge file
#' @param species_file the output file from the sep_sbtab function or an existing species file
#' @param compartments_file the output file from the sep_sbtab function or an existing compartments file
#'
#' @return A network graph for unmerged files
#' @export
#'
#' @import igraph
#' @import ggraph
#' @import ggplot2
#'
#' @examples
#' physmap6_edges <- system.file("extdata", "physmap6_edges.rds", package="sbtabr")
#' physmap6_species <- system.file("extdata", "physmap6_species.rds", package="sbtabr")
#' physmap6_compartments <- system.file("extdata", "physmap6_compartments.rds", package="sbtabr")
#' net_graph(physmap6_edges, physmap6_species, physmap6_compartments)
net_graph <- function(edge_file, species_file, compartments_file){
  # Function is for unmerged files, for merged files please use the merged_net_graph function

  # Load files
  edge_list <- readRDS(edge_file)
  species_list <- readRDS(species_file)
  compartments_list <- readRDS(compartments_file)

  # Prepare data for ggraph object
  edge_list <- edge_list[,c(4,5,3)] # Only keep needed columns

  species_list <- species_list[!duplicated(species_list[["ID"]]), ] # Correct double values
  edge_list <- edge_list[!duplicated(edge_list[,c("Compoundname", "Productname")]), ] # Correct double values

  # Create ggraph object
  network <- graph_from_data_frame(d=edge_list, vertices=species_list, directed=T)

  # Plot network
  set.seed(123)
  network <- ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey66",
                   arrow = arrow(angle = 20, length = unit(2, "mm"),
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(fill = species_list$Location), size = 3, shape = 21) +
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    scale_fill_discrete(labels = compartments_list$Name,
                        name = "Substance location")
  theme_graph(base_family="sans")
  print(network)
}
