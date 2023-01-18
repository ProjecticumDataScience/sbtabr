# Function to merge prepped SBtab dataframes made with SBtab_to_dfs() and premerge()
## fls is a list of prepped files to merge (all have to be the same type!)
## oname is the outputname of the merged file
## odir is the (already existing) outputfolder

merge.prepped <- function(fls, oname, odir = getwd()) {
  # Turn the files into a list dataframes
  dfs <- lapply(fls, readRDS)
  # Merge the dataframes
  merge <- do.call(bind_rows, dfs)
  # Save the merged file
  saveRDS(merge, paste0(odir, "/", oname, ".rds"))
}

## Making file lists
compartmentslist <- c("data/compartments/prepped_physmap6_compartments.rds", "data/compartments/prepped_physmap7_compartments.rds")
edgeslist <-c("data/edges/prepped_physmap6_edges.rds", "data/edges/prepped_physmap7_edges.rds")
reactionslist <- c("data/reactions/prepped_physmap6_reactions.rds", "data/reactions/prepped_physmap7_reactions.rds")
specieslist <- c("data/species/prepped_physmap6_species.rds", "data/species/prepped_physmap7_species.rds")
## Trying out the function
merge.prepped(compartmentslist, "phys67_compartments", "data/merged")
merge.prepped(edgeslist, "phys67_edges", "data/merged")
merge.prepped(reactionslist, "phys67_reactions", "data/merged")
merge.prepped(specieslist, "phys67_species", "data/merged")

# It works! :D
