# Function to prepare SBtab dataframes made with sep.sbtab() for merging
## fname is the file path of the file to be prepped
## og is the identifier or name of the original file the file came from
## odir is the outputdirectory
## reactionsdata asks if the file contains reactions (i.e. multiple columns containing IDs)

#' Prepare SBtab dataframes made with sep.sbtab() for merging
#'
#' @param fname The file path of the file to be prepped
#' @param ogid The identifier or name of the original file the file came from
#' @param odir The outputdirectory
#' @param reactionsdata Asks if the file contains reactions (i.e. multiple columns containing IDs)
#' @param edgesdata Asks if the file contains edges (i.e. multiple columns containing IDs)
#'
#' @return .rds files prepared for merging
#' @export
#'
#' @examples
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
