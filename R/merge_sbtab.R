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
#' physmap6 <- system.file("extdata", "physmap6.tsv", package="PackageONTOX")
#' physmap7 <- system.file("extdata", "physmap7.tsv", package="PackageONTOX")
#' physmap8 <- system.file("extdata", "physmap8.tsv", package="PackageONTOX")
#' physmap9 <- system.file("extdata", "physmap9.tsv", package="PackageONTOX")
#' merge_sbtab(c(physmap6, physmap7, physmap8, physmap9), 'merged_physmap6789')
merge_sbtab <- function(filelist, outputname, outputdir = getwd()) {
  # Create a (temporary) directory to store inbetween files in
  dir.create(file.path(outputdir, "merging"), showWarnings = FALSE)
  tempdir <- paste0(outputdir, "/merging")

  # Seperate the tables in the SBtab file to sperate dataframes using sep_sbtab
  dir.create(file.path(tempdir, "seperated"), showWarnings = FALSE) # Create the directory
  mapply(sep_sbtab, filelist,
         oname = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = tempdir)

  # Prepare the seperated dataframes for merging using prep_merge
  dir.create(file.path(tempdir, "prepped"), showWarnings = FALSE) # Create the directory
  ## Prep the compartments
  mapply(prep_merge, paste0(tempdir, "/compartments/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_compartments.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"))

  ## Prep the edges
  mapply(prep_merge, paste0(tempdir, "/edges/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_edges.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), edgesdata = TRUE)

  ## Prep the reactions
  mapply(prep_merge, paste0(tempdir, "/reactions/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_reactions.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), reactionsdata = TRUE)

  ## Prep the species
  mapply(prep_merge, paste0(tempdir, "/species/",
                            str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
                            "_species.rds"),
         ogid = str_sub(basename(filelist), 0, nchar(basename(filelist))-4),
         odir = paste0(tempdir, "/prepped"), speciesdata = TRUE)

  # Merge the prepped dataframes using merge_prepped
  ## Make lists with the files of each data type
  compartmentslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_compartments.rds"))
  edgeslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_edges.rds"))
  reactionslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_reactions.rds"))
  specieslist <- c(paste0(tempdir, "/prepped/prepped_", str_sub(basename(filelist), 0, nchar(basename(filelist))-4), "_species.rds"))

  ## Merge each list
  merge_prepped(compartmentslist, paste0(outputname, "_compartments"), outputdir)
  merge_prepped(edgeslist, paste0(outputname, "_edges"), outputdir)
  merge_prepped(reactionslist, paste0(outputname, "_reactions"), outputdir)
  merge_prepped(specieslist, paste0(outputname, "_species"), outputdir)

  # Delete temporary files
  unlink(tempdir, recursive = TRUE, force = TRUE)
}
