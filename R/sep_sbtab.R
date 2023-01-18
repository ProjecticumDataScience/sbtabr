# Eisen voor de SBtab
## Tab seperated
## Three tables (reaction, species and compartment)
## Reaction ID's start with "re"
## Compounds in the reaction table are divided in !Products, !Reactants (and !Modifiers)
## Species ID's start with "s" followed by a number
## Compartment ID's start with "c" followed by a number

# Required libraries
library(stringr)
library(tidyverse)
library(dplyr)

# Function to read SBtab (TSV) into seperate dataframes
sep.sbtab <-
  function(fname, oname, odir = getwd(), colnum = 25) { # fname is a tsv file path, oname is the outputname, colnum is the ncol of the widest df

    # Input the tsv, use fill to create equal columns per row
    # Adding colnames to make sure the amount of columns is not just based on the first table
    mydata <- read.table(fname, sep="\t", stringsAsFactors = FALSE, fill = TRUE, blank.lines.skip = TRUE, col.names = c(1:colnum))
    data <- mydata[(2):dim(mydata)[1],]

    # Create the df with all the info in the SBtab
    sbtab <- data.frame(data, row.names = NULL)
    sbtab[sbtab == "" | sbtab == " "] <- NA # Turn the empty spaces into NA's
    sbtab <- sbtab %>% select_if(~ !all(is.na(.))) # Get rid of empty columns
    columns <- sbtab %>% filter(X1 == "!ID") # Take the columnames per table for later use
    dir.create(file.path(odir, "full"), showWarnings = FALSE) # Create the directory
    saveRDS(sbtab, paste0(odir, "/full/", oname, "_full.rds")) # Save the file

    # Create a separate object for the reactions table
    reactions <- filter(sbtab, str_detect(X1, "^re*")) # Take the reactions from the SBtab
    colnames(reactions) <- columns[1,c(1:ncol(reactions))] # Add the colnames specific to this table
    reactions <- reactions %>% select(where(~ !all(is.na(.)))) # Get rid of empty columns
    colnames(reactions) <- substr(colnames(reactions), 2, nchar(columns)) # Get rid of the ! in columnnames
    dir.create(file.path(odir, "reactions"), showWarnings = FALSE) # Create the directory
    saveRDS(reactions, paste0(odir, "/reactions/", oname, "_reactions.rds")) # Save the file

    # For the edges, the compounds in the reactionformula need to be seperated
    edges <- reactions
    if (any(colnames(edges) %in% c("ReactionFormula"))){
      edges$Reactants <- lapply(strsplit(edges$ReactionFormula, "<=>"), "[", 1)
      edges$Products <- lapply(strsplit(edges$ReactionFormula, "<=>"), "[", 2)
    }

    # For the edges Create an object that uses one row per edge for possible iGraph visualizations
    if (any(colnames(edges) %in% "Modifiers")) {
      edges <- pivot_longer(edges, cols = c(Modifiers, Reactants),
                            names_to = "Compound.Type", values_to = "Compounds")
    }
    edges <- edges[, c("Compounds", "Products", "ID")] # leave the row index blank to keep all rows
    dir.create(file.path(odir, "edges"), showWarnings = FALSE) # Create the directory
    saveRDS(edges, paste0(odir, "/edges/", oname, "_edges.rds")) # Save the file

    # Create a separate object for the species table
    # This object also functions as a nodes object for possible iGraph visualistions
    species <- filter(sbtab, str_detect(X1, "^s[0-9]*")) # Take the species from the SBtab
    colnames(species) <- columns[2,c(1:ncol(species))] # Add the colnames specific to the table
    species <- species %>% select(where(~ !all(is.na(.)))) # Get rid of empty columns
    colnames(species) <- substr(colnames(species), 2, nchar(columns)) # Get rid of the ! in columnnames
    dir.create(file.path(odir, "species"), showWarnings = FALSE) # Create the directory
    saveRDS(species, paste0(odir, "/species/", oname, "_species.rds")) # Save the file

    # Create a separate object for the compartments table
    compartments <- filter(sbtab, str_detect(X1, "^c[0-9]*")) # Take the compartments from the SBtab
    colnames(compartments) <- columns[3,c(1:ncol(compartments))] # Add the colnames specific to the table
    compartments <- compartments %>% select(where(~ !all(is.na(.)))) # Get rid of empty columns
    colnames(compartments) <- substr(colnames(compartments), 2, nchar(columns)) # Get rid of the ! in columnname
    dir.create(file.path(odir, "compartments"), showWarnings = FALSE) # Create the directory
    saveRDS(compartments, paste0(odir, "/compartments/", oname, "_compartments.rds")) # Save the file
  }

# Function executed with the examples:
sep.sbtab("SBtab_examples/physmap6.tsv", "physmap6", "data")
sep.sbtab("SBtab_examples/physmap7.tsv", "physmap7", "data")
sep.sbtab("SBtab_examples/physmap8.tsv", "physmap8", "data")
sep.sbtab("SBtab_examples/physmap9.tsv", "physmap9", "data")
sep.sbtab("SBtab_examples/physmap10.tsv", "physmap10", "data")

# Looks good! :D