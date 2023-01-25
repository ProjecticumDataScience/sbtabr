## code to prepare `prepped_physmap0_` files as found in data/compartments, data/edges, data/full, data/reactions and data/species

## physmap6
prep_merge("data/compartments/physmap6_compartments.rds", "physmap6", "data/compartments")
prep_merge("data/edges/physmap6_edges.rds", "physmap6", "data/edges", edgesdata = TRUE)
prep_merge("data/reactions/physmap6_reactions.rds", "physmap6", "data/reactions", reactionsdata = TRUE)
prep_merge("data/species/physmap6_species.rds", "physmap6", "data/species", speciesdata = TRUE)

## physmap7
prep_merge("data/compartments/physmap7_compartments.rds", "physmap7", "data/compartments")
prep_merge("data/edges/physmap7_edges.rds", "physmap7", "data/edges", edgesdata = TRUE)
prep_merge("data/reactions/physmap7_reactions.rds", "physmap7", "data/reactions", reactionsdata = TRUE)
prep_merge("data/species/physmap7_species.rds", "physmap7", "data/species", speciesdata = TRUE)

## physmap8
prep_merge("data/compartments/physmap8_compartments.rds", "physmap8", "data/compartments")
prep_merge("data/edges/physmap8_edges.rds", "physmap8", "data/edges", edgesdata = TRUE)
prep_merge("data/reactions/physmap8_reactions.rds", "physmap8", "data/reactions", reactionsdata = TRUE)
prep_merge("data/species/physmap8_species.rds", "physmap8", "data/species", speciesdata = TRUE)

## physmap9
prep_merge("data/compartments/physmap9_compartments.rds", "physmap9", "data/compartments")
prep_merge("data/edges/physmap9_edges.rds", "physmap9", "data/edges", edgesdata = TRUE)
prep_merge("data/reactions/physmap9_reactions.rds", "physmap9", "data/reactions", reactionsdata = TRUE)
prep_merge("data/species/physmap9_species.rds", "physmap9", "data/species", speciesdata = TRUE)
