## code to prepare `physmap*_` files as found in data/compartments, data/edges, data/full, data/reactions and data/species

# Physmap 6
sep_sbtab('data-raw/physmap6.tsv', 'physmap6', "data")
physmap6_reactions <- readRDS("data/reactions/physmap6_reactions.rds")
usethis::use_data(physmap6_reactions)





# Physmap 7
sep_sbtab("data-raw/physmap7.tsv", "physmap7", "data")

# Physmap 8
sep_sbtab("data-raw/physmap8.tsv", "physmap8", "data")

# Physmap 9
sep_sbtab("data-raw/physmap9.tsv", "physmap9", "data")
