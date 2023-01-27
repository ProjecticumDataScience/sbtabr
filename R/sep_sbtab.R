#' Seperate SBtab files into seperate dataframes per table
#'
#' @param fname A tsv file path to an SBtab file
#' @param oname The outputname
#' @param odir The output directory
#' @param colnum The number of columns of the widest dataframe
#'
#' @return Seperates SBtab files into reactions, species and compounds, also saves a dataframe with full infoormation.
#' @export
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr select_if
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom tidyr pivot_longer
#' @importFrom tidyr separate_rows
#' @importFrom tidyr drop_na
#' @importFrom tidyselect where
#' @importFrom dplyr distinct
#' @importFrom dplyr left_join
#'
#' @examples
#' physmap6 <- system.file("extdata", "physmap6.tsv", package="PackageONTOX")
#' sep_sbtab(physmap6, "physmap6")
#' physmap7 <- system.file("extdata", "physmap7.tsv", package="PackageONTOX")
#' sep_sbtab(physmap7, "physmap7")
sep_sbtab <-
  function(fname, oname, odir = getwd(), colnum = 25) {

    # Create outputdirectory if it doesn't already exist
    dir.create(file.path(getwd(), odir), showWarnings = FALSE)

    # Input the tsv
    ## Use fill to create equal columns per row
    ## Adding numbered colnames to make sure the amount of columns is not only based on the first table
    mydata <- read.table(fname, sep="\t", stringsAsFactors = FALSE, fill = TRUE, blank.lines.skip = TRUE, col.names = c(1:colnum))
    data <- mydata[(2):dim(mydata)[1],]

    # Create the full dataframe
    sbtab <- data.frame(data, row.names = NULL)
    sbtab[sbtab == "" | sbtab == " "] <- NA ## Turn the empty spaces into NA's
    sbtab <- sbtab %>% select_if(~ !all(is.na(.))) ## Get rid of empty columns
    columns <- sbtab %>% filter(X1 == "!ID") ## Save the columnames per table for later use
    dir.create(file.path(odir, "full"), showWarnings = FALSE) ## Create the directory
    saveRDS(sbtab, paste0(odir, "/full/", oname, "_full.rds")) ## Save the file

    # Create the separate reactions file
    reactions <- filter(sbtab, str_detect(X1, "^re*")) ## Take the reactions from the SBtab
    colnames(reactions) <- columns[1,c(1:ncol(reactions))] ## Add the colnames specific to this table
    reactions <- reactions %>% select(where(~ !all(is.na(.)))) ## Get rid of empty columns
    colnames(reactions) <- substr(colnames(reactions), 2, nchar(columns)) ## Get rid of the ! in columnnames
    reactions <- distinct(reactions) ## Get rid of duplicates
    dir.create(file.path(odir, "reactions"), showWarnings = FALSE) ## Create the directory
    saveRDS(reactions, paste0(odir, "/reactions/", oname, "_reactions.rds")) ## Save the file

    # Create the separate species file
    ## This file will also function as input for the nodes in ggraph visualizations
    species <- filter(sbtab, str_detect(X1, "^s[0-9]*")) ## Take the species from the SBtab
    colnames(species) <- columns[2,c(1:ncol(species))] ## Add the colnames specific to the table
    species <- species %>% select(where(~ !all(is.na(.)))) ## Get rid of empty columns
    colnames(species) <- substr(colnames(species), 2, nchar(columns)) ## Get rid of the ! in columnnames
    species <- species[,c(2,1,3:ncol(species))] ## Reorder the columns to start with name instead of ID
    speciesnames <- species[,c(1,2)] ## Take out names and ID's for later use
    species <- distinct(species) ## Get rid of duplicates
    dir.create(file.path(odir, "species"), showWarnings = FALSE) ## Create the directory
    saveRDS(species, paste0(odir, "/species/", oname, "_species.rds")) ## Save the file

    # Create the edges file
    ## We use the reactions to create an edges file, which is needed for visualizations
    ## The compounds in the reactionformula need to be put in separate columns
    edges <- reactions
    if (any(colnames(edges) %in% c("ReactionFormula"))){
      edges$Reactants <- lapply(strsplit(edges$ReactionFormula, "<=>"), "[", 1)
      edges$Products <- lapply(strsplit(edges$ReactionFormula, "<=>"), "[", 2)
    }

    ## There can only be one edge per row
    if (any(colnames(edges) %in% "Modifiers")) {
      edges <- pivot_longer(edges, cols = c(Modifiers, Reactants),
                            names_to = "Compound.Type", values_to = "Compounds")
    }
    edges <- separate_rows(edges, Compounds, sep = ", ") ## One observation per compound
    edges <- drop_na(edges) ## Get rid of empty values
    edges <- edges[, c("Compounds", "Products", "ID")] ## Leave the row index blank to keep all rows
    ## Adding compound names
    edges <- edges %>% left_join(speciesnames, by=c('Compounds'='ID'))
    colnames(edges)[colnames(edges) == "Name"] ="Compoundname"
    ## Adding product names
    edges <- edges %>% left_join(speciesnames, by=c('Products'='ID'))
    colnames(edges)[colnames(edges) == "Name"] ="Productname"

    edges <- distinct(edges) ## Getting rid of duplicates
    dir.create(file.path(odir, "edges"), showWarnings = FALSE) ## Create the directory
    saveRDS(edges, paste0(odir, "/edges/", oname, "_edges.rds")) ## Save the file

    # Create the separate compartments file
    compartments <- filter(sbtab, str_detect(X1, "^c[0-9]*")) ## Take the compartments from the SBtab
    colnames(compartments) <- columns[3,c(1:ncol(compartments))] ## Add the colnames specific to the table
    compartments <- compartments %>% select(where(~ !all(is.na(.)))) ## Get rid of empty columns
    colnames(compartments) <- substr(colnames(compartments), 2, nchar(columns)) ## Get rid of the ! in columnname
    compartments <- distinct(compartments) ## Get rid of duplicates
    dir.create(file.path(odir, "compartments"), showWarnings = FALSE) ## Create the directory
    saveRDS(compartments, paste0(odir, "/compartments/", oname, "_compartments.rds")) ## Save the file
  }
