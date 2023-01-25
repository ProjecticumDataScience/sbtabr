## code to put the filepaths used for examples in rda's
library(here)

## sep_sbtab and merge_sbtab example data
physmap6 <- here::here("data-raw/physmap6.tsv")
usethis::use_data(physmap6, overwrite = TRUE)
physmap7 <- here::here("data-raw/physmap7.tsv")
usethis::use_data(physmap7, overwrite = TRUE)
physmap8 <- here::here("data-raw/physmap8.tsv")
usethis::use_data(physmap8, overwrite = TRUE)
physmap9 <- here::here("data-raw/physmap9.tsv")
usethis::use_data(physmap9, overwrite = TRUE)

## prep_merge and net_graph example data
sep_sbtab('data-raw/physmap6.tsv', 'physmap6', "data")
physmap6_edges <- here::here("data/edges/physmap6_edges.rds")
usethis::use_data(physmap6_edges, overwrite = TRUE)
physmap6_species <- here::here("data/species/physmap6_species.rds")
usethis::use_data(physmap6_species, overwrite = TRUE)
physmap6_compartments <- here::here("data/compartments/physmap6_compartments.rds")
usethis::use_data(physmap6_compartments, overwrite = TRUE)

## merge_prepped example data
prep_merge("data/reactions/physmap6_reactions.rds", "physmap6", "data/reactions", reactionsdata = TRUE)
prepped_physmap6_reactions <- here::here("data/reactions/prepped_physmap6_reactions.rds")
usethis::use_data(prepped_physmap6_reactions, overwrite = TRUE)
prep_merge("data/reactions/physmap7_reactions.rds", "physmap7", "data/reactions", reactionsdata = TRUE)
prepped_physmap7_reactions <- here::here("data/reactions/prepped_physmap7_reactions.rds")
usethis::use_data(prepped_physmap7_reactions, overwrite = TRUE)

# merged_net_graph example data
merge_sbtab(c("data-raw/physmap6.tsv", "data-raw/physmap7.tsv"), 'merged_physmap67', 'data/merged')
merged_physmap67_edges <- here::here("data/merged/merged_physmap67_edges.rds")
usethis::use_data(merged_physmap67_edges, overwrite = TRUE)
merged_physmap67_species <- here::here("data/merged/merged_physmap67_species.rds")
usethis::use_data(merged_physmap67_species, overwrite = TRUE)
merged_physmap67_compartments <- here::here("data/merged/merged_physmap67_compartments.rds")
usethis::use_data(merged_physmap67_compartments, overwrite = TRUE)

merge_sbtab(c("data-raw/physmap6.tsv", "data-raw/physmap7.tsv",
              "data-raw/physmap8.tsv", "data-raw/physmap9.tsv"),
            'merged_physmap6789', 'data/merged')
merged_physmap6789_edges <- here::here("data/merged/merged_physmap6789_edges.rds")
usethis::use_data(merged_physmap6789_edges, overwrite = TRUE)
merged_physmap6789_species <- here::here("data/merged/merged_physmap6789_species.rds")
usethis::use_data(merged_physmap6789_species, overwrite = TRUE)
merged_physmap6789_compartments <- here::here("data/merged/merged_physmap6789_compartments.rds")
usethis::use_data(merged_physmap6789_compartments, overwrite = TRUE)
