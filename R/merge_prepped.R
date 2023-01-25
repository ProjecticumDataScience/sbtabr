#' Merge prepped SBtab dataframes made with sep_sbtab() and prep_merge()
#'
#' @param fls A list of prepped files to merge (all have to be the same type! i.e. reactions, edges, etc.)
#' @param oname The outputname of the merged file
#' @param odir The outputfolder
#'
#' @return A .rds file containing the merged dataframes from that type
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom utils read.table
#'
#' @examples
#' merge_prepped(c(prepped_physmap6_reactions, prepped_physmap7_reactions),
#' 'merged_physmap67_reactions')
merge_prepped <- function(fls, oname, odir = getwd()) {
  # Create outputdirectory if it doesn't already exist
  dir.create(file.path(getwd(), odir), showWarnings = FALSE)
  # Turn the files into a list dataframes
  dfs <- lapply(fls, readRDS)
  # Merge the dataframes
  merge <- do.call(bind_rows, dfs)
  # Save the merged file
  saveRDS(merge, paste0(odir, "/", oname, ".rds"))
}
