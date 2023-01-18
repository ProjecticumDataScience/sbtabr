# Function to prepare SBtab dataframes made with sep.sbtab() for merging
## fname is the file path of the file to be prepped
## og is the identifier or name of the original file the file came from
## odir is the outputdirectory
## reactionsdata asks if the file contains reactions (i.e. multiple columns containing IDs)

prep.merge <- function(fname, ogid, odir = getwd(), reactionsdata = FALSE, edgesdata = FALSE) {
  # Import the file and add a column with the original filename
  prepped <- readRDS(fname) %>% mutate(filename = ogid)
  prepped$ID <- paste0(prepped$ID, ".", ogid)
  # Reactions files also have id's in other columns
  if (reactionsdata == TRUE){
    prepped$Reactants <- paste0(prepped$Reactants, ".", ogid)
    prepped$Products <- paste0(prepped$Products, ".", ogid)
    prepped$Modifiers <- paste0(prepped$Modifiers, ".", ogid)
  }
  # Edges files also have id's in other columns
  if (edgesdata == TRUE){
    prepped$Products <- paste0(prepped$Products, ".", ogid)
    prepped$Compounds <- paste0(prepped$Compounds, ".", ogid)
  }
  saveRDS(prepped, paste0(odir, "/prepped_", basename(fname)))
}

# Trying it out:
prep.merge("data/compartments/physmap6_compartments.rds", "physmap6", "data/compartments")
prep.merge("data/edges/physmap6_edges.rds", "physmap6", "data/edges", edgesdata = TRUE)
prep.merge("data/reactions/physmap6_reactions.rds", "physmap6", "data/reactions", reactionsdata = TRUE)
prep.merge("data/species/physmap6_species.rds", "physmap6", "data/species")

prep.merge("data/compartments/physmap7_compartments.rds", "physmap7", "data/compartments")
prep.merge("data/edges/physmap7_edges.rds", "physmap6", "data/edges", edgesdata = TRUE)
prep.merge("data/reactions/physmap7_reactions.rds", "physmap7", "data/reactions", reactionsdata = TRUE)
prep.merge("data/species/physmap7_species.rds", "physmap7", "data/species")

# It works! :D
