## code to prepare `merged_` files as found in folder data/merged

## merged_physmap67_*
merge.prepped(c("data/edges/prepped_physmap6_edges.rds", "data/edges/prepped_physmap7_edges.rds"),
              "merged_physmap67_edges", "data/merged")
merge.prepped(c("data/species/prepped_physmap6_species.rds", "data/species/prepped_physmap7_species.rds"),
              "merged_physmap67_species", "data/merged")

## merged_physmap6789_*
merge.prepped(c("data/edges/prepped_physmap6_edges.rds", "data/edges/prepped_physmap7_edges.rds",
                "data/edges/prepped_physmap8_edges.rds", "data/edges/prepped_physmap9_edges.rds"),
              "merged_physmap6789_edges", "data/merged")
merge.prepped(c("data/species/prepped_physmap6_species.rds", "data/species/prepped_physmap7_species.rds",
                "data/species/prepped_physmap8_species.rds", "data/species/prepped_physmap9_species.rds"),
              "merged_physmap6789_species", "data/merged")
