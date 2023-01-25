#' Title
#'
#' @param edge_list the output file from the merge_sbtab function or an existing edge file
#' @param species_list the output file from the merge_sbtab function or an existing species file
#' @param compartments_list the output file from the merge_sbtab function or an existing compartments file
#'
#' @return A network graph for merged files
#' @export
#'
#' @importFrom igraph graph_from_data_frame
#' @importFrom ggraph ggraph
#' @importFrom vctors vec_count
#'
#' @examples
#' merged_net_graph("data/merged/merged_physmap67_edge_list.rds", "data/merged/merged_physmap67_species.rds", "data/merged/merged_physmap67_compartments.rds")
#'
#' merged_net_graph("data/merged/merged_physmap789_edge_list.rds", "data/merged/merged_physmap789_species.rds", "data/merged/merged_physmap789_compartments.rds")
merged_net_graph <- function(edge_list, species_list, compartments_list){
  # Function is for merged files, for unmerged files please use the net_graph function

  # Prepare data for ggraph object
  edge_list <- edge_list %>% mutate(Reaction = paste0(edge_list$Compoundname, edge_list$Productname))  # Add frequency to data frame
  counts_edge <- vec_count(edge_list$Reaction)
  edge_list <- edge_list %>% left_join(counts_edge, by=c('Reaction'='key'))
  edge_list <- edge_list[,c(4,5,3,8)] # Only keep needed columns

  counts_species <- vec_count(species_list$Name) # Add frequency to data frame
  species_list <- species_list %>% left_join(counts_species, by=c('Name'='key'))

  species_list <- species_list[!duplicated(species_list[["Name"]]), ] # Correct uniqueness of links in list
  edge_list <- edge_list[!duplicated(edge_list[,c("Compoundname", "Productname")]), ] # Correct uniqueness of links in list

  # Create ggraph object
  network <- graph_from_data_frame(d=edge_list, vertices=species_list, directed=T)

  # Plot network
  set.seed(123)
  ggraph(network, layout = "nicely") +
    geom_edge_link(aes(width = edge_list$count, end_cap = circle(3, "mm")), edge_colour = "grey",
                   arrow = arrow(angle = 20, length = unit(2, "mm"),
                                 ends = "last", type = "closed")) +
    geom_node_point(aes(color = species_list$Location), size = species_list$count*2) +
    scale_colour_discrete(name = "Substance location", labels = compartments_list$Name) +
    geom_node_text(aes(label = species_list$Name), repel = TRUE) +
    scale_edge_width(range = c(0.5, 2)) +
    scale_size(range = c(0.2, 8)) +
    theme_graph()
}
