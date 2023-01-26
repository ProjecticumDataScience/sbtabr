#' Prepare SBtab dataframes made with sep_sbtab for merging
#'
#' @param fname The file path of the file to be prepped
#' @param ogid The identifier or name of the original file the file came from
#' @param odir The outputdirectory
#' @param reactionsdata Asks if the file contains reactions (i.e. multiple columns containing IDs)
#' @param edgesdata Asks if the file contains edges (i.e. multiple columns containing IDs)
#' @param speciesdata Asks if the file contains species (i.e. multiple columns containing IDs)
#'
#' @return .rds files prepared for merging
#' @export
#'
#' @examples
#' physmap6_species <- system.file("extdata", "physmap6_species.rds", package="PackageONTOX")
#' prep_merge(physmap6_species, 'physmap6', speciesdata = TRUE)
prep_merge <- function(fname, ogid, odir = getwd(), reactionsdata = FALSE, edgesdata = FALSE, speciesdata = FALSE) {
  # Create outputdirectory if it doesn't already exist
  dir.create(file.path(getwd(), odir), showWarnings = FALSE)

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
  # Species files also have id's in other columns
  if (speciesdata == TRUE){
    prepped$Location <- paste0(prepped$Location, ".", ogid)
  }
  saveRDS(prepped, paste0(odir, "/prepped_", basename(fname)))
}
