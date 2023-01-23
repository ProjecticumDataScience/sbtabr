#' Merge multiple SBtab files into seperate dataframes per table type
#'
#' @param filelist A list of filepaths to TSV formatted SBtabs to merge
#' @param outputname A string which each merged file begins with
#' @param outputdir The output folder for the merged file
#'
#' @return .rds file inside output directory
#' @export
#'
#' @import stringr
#'
#' @examples
#' merge_sbtab(c("data-raw/physmap6.tsv", "data-raw/physmap7.tsv"),
#' "merged_physmap67", "data/merged")
#'
#' merge_sbtab(c("data-raw/physmap6.tsv",
#' "data-raw/physmap7.tsv",
#' "data-raw/physmap8.tsv",
#' "data-raw/physmap9.tsv"), "merged_physmap6789", "data/merged")
merge_sbtab <- function(filelist, outputname, outputdir) {
  dir.create(file.path(outputdir, "merging"), showWarnings = FALSE)
  tempdir <- paste0(outputdir, "/merging")
  # Seperate
  dir.create(file.path(tempdir, "seperated"), showWarnings = FALSE) # Create the directory
  mapply(sep_sbtab, filelist,
         oname = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = tempdir)

  dir.create(file.path(tempdir, "prepped"), showWarnings = FALSE) # Create the directory

  # Prep compartments
  mapply(prep_merge, paste0(tempdir, "/compartments/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_compartments.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"))

  # Prep edges
  mapply(prep_merge, paste0(tempdir, "/edges/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_edges.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), edgesdata = TRUE)

  # Prep reactions
  mapply(prep_merge, paste0(tempdir, "/reactions/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_reactions.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), reactionsdata = TRUE)

  # Prep species
  mapply(prep_merge, paste0(tempdir, "/species/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_species.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), speciesdata = TRUE)

  # Making merge lists
  compartmentslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_compartments.rds"))
  edgeslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_edges.rds"))
  reactionslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_reactions.rds"))
  specieslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_species.rds"))

  # Merge
  merge_prepped(compartmentslist, paste0(outputname, "_compartments"), outputdir)
  merge_prepped(edgeslist, paste0(outputname, "_edges"), outputdir)
  merge_prepped(reactionslist, paste0(outputname, "_reactions"), outputdir)
  merge_prepped(specieslist, paste0(outputname, "_species"), outputdir)

  # Delete temporary files
  unlink(tempdir, recursive = TRUE, force = TRUE)
}
