#' physmap6
#'
#' An original SBtab file as provided by the SysRev platform
#'
#' @format A file path to a .tsv file containing an SBtab
#' @source <data-raw/physmap6.tsv>
"physmap6"

#' physmap7
#'
#' An original SBtab file as provided by the SysRev platform
#'
#' @format A file path to a .tsv file containing an SBtab
#' @source <data-raw/physmap7.tsv>
"physmap7"

#' physmap8
#'
#' An original SBtab file as provided by the SysRev platform
#'
#' @format A file path to a .tsv file containing an SBtab
#' @source <data-raw/physmap8.tsv>
"physmap8"

#' physmap9
#'
#' An original SBtab file as provided by the SysRev platform
#'
#' @format A file path to a .tsv file containing an SBtab
#' @source <data-raw/physmap9.tsv>
"physmap9"

#' physmap6_species
#'
#' Result of putting the physmap6.tsv file through sep_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap6.tsv>
"physmap6_species"

#' physmap6_edges
#'
#' Result of putting the physmap6.tsv file through sep_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap6.tsv>
"physmap6_edges"

#' physmap6_compartments
#'
#' Result of putting the physmap6.tsv file through sep_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap6.tsv>
"physmap6_compartments"

#' prepped_physmap6_reactions
#'
#' Result of putting the physmap6.tsv file through sep_sbtab and prep_merge
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap6.tsv>
"prepped_physmap6_reactions"

#' prepped_physmap7_reactions
#'
#' Result of putting the physmap7.tsv file through sep_sbtab and prep_merge
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"prepped_physmap7_reactions"

#' merged_physmap67_edges
#'
#' Result of putting physmap6 and physmap7 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap67_edges"

#' merged_physmap67_species
#'
#' Result of putting physmap6 and physmap7 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap67_species"

#' merged_physmap67_compartments
#'
#' Result of putting physmap6 and physmap7 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap67_compartments"

#' merged_physmap6789_edges
#'
#' Result of putting physmap6, 7, 8 and 9 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap6789_edges"

#' merged_physmap6789_species
#'
#' Result of putting physmap6, 7, 8 and 9 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap6789_species"

#' merged_physmap6789_compartments
#'
#' Result of putting physmap6, 7, 8 and 9 through merge_sbtab
#'
#' @format A file path to a .rds file containing a dataframe
#' The data frame has ... rows and ... columns:
#' \describe{
#'   \item{Compounds}{Compound ID's}
#'   \item{Products}{Product ID's}
#'   \item{ID}{Reaction ID}
#'   \item{Compoundname}{Compound name}
#'   \item{Productname}{Product name}
#'   \item{Productname}{Name of original file}
#'   ...
#' }
#' @source <data-raw/physmap7.tsv>
"merged_physmap6789_compartments"
