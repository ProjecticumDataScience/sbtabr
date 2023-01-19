
#' Merge prepped SBtab dataframes made with SBtab_to_dfs() and premerge()
#'
#' @param fls A list of prepped files to merge (all have to be the same type!)
#' @param oname The outputname of the merged file
#' @param odir The (already existing) outputfolder
#'
#' @return A .rds file
#' @export
#'
#' @examples

merge.prepped <- function(fls, oname, odir = getwd()) {
  # Turn the files into a list dataframes
  dfs <- lapply(fls, readRDS)
  # Merge the dataframes
  merge <- do.call(bind_rows, dfs)
  # Save the merged file
  saveRDS(merge, paste0(odir, "/", oname, ".rds"))
}
