#' Merge prepped SBtab dataframes made with sep.sbtab() and prep.merge()
#'
#' @param fls A list of prepped files to merge (all have to be the same type! i.e. reactions, edges, etc.)
#' @param oname The outputname of the merged file
#' @param odir The outputfolder
#'
#' @return A .rds file containing the merged dataframes
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom utils read.table
#'
#' @examples
#'merge.prepped(edgeslist, "phys67_edges", "data/merged")
#'
#'merge.prepped(reactionslist, "phys6789_reactions", "data/merged")
merge.prepped <- function(fls, oname, odir = getwd()) {
  # Create outputdirectory if it doesn't already exist
  dir.create(file.path(getwd(), odir), showWarnings = FALSE)
  # Turn the files into a list dataframes
  dfs <- lapply(fls, readRDS)
  # Merge the dataframes
  merge <- do.call(bind_rows, dfs)
  # Save the merged file
  saveRDS(merge, paste0(odir, "/", oname, ".rds"))
}
