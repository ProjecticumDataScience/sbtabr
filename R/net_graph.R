#' Title
#'
#' @param edge_list the output file from the sep_sbtab function or an existing edge file
#' @param species_list the output file from the sep_sbtab function or an existing species file
#' @param compartments_list the output file from the sep_sbtab function or an existing compartments file
#'
#' @return A network graph for unmerged files
#' @export
#'
#' @importFrom igraph graph_from_data_frame
#' @importFrom ggraph ggraph
#'
#' @examples
#' net_graph("data/edges/physmap6_edges.rds", "data/species/physmap6_species.rds", "data/compartments/physmap6_compartments.rds")
#'
#' net_graph("data/edges/physmap7_edges.rds", "data/species/physmap7_species.rds", "data/compartments/physmap7_compartments.rds")
net_graph <- function(edge_file, species_file, compartments_file){
  # Function is for unmerged files, for merged files please use the merged_net_graph function

  # Load files
  edge_list <- readRDS(edge_file)
  species_list <- readRDS(species_file)
  compartments_list <- readRDS(compartments_file)

  # Prepare data for ggraph object
  species_list <- species_list[!duplicated(species_list[["ID"]]), ] # Correct uniqueness of links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compounds", "Products")]), ] # Correct uniqueness of links in list

  # Create ggraph object
  network <- graph_from_data_frame(d=edge_list, vertices=species_list, directed=T)

  # Plot network
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(end_cap = circle(3, "mm")), edge_colour = "grey66",
                   arrow = arrow(angle = 20, length = unit(2, "mm"),
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(fill = species_list$Location), size = 3, shape = 21) +
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    scale_edge_width(range = c(0.2, 8)) +
    scale_size(range = c(0.2, 8)) +
    scale_fill_discrete(labels = compartments_list$Name,
                        name = "Substance location")
}
