#' Converts sysrev file into SBtab and SBML file
#'
#' @param pid Identifier of used papers
#' @param aid Identifier of paper authors
#' @param token Token
#' @param documentname Output document name
#'
#' @return Two .rds files, SBtab and SBML
#' @export
#'
#' @examples To do

sysrev_to_tsv_xml <- function(pid, aid, token, documentname){
  # Source sysrev project
  sbtabfile <- list_answers_unnested(pid, aid, "aid", token)
  # Modify
  if("Modifier" %in% names(sbtabfile$Reaction)){
    sbtabfile$Reaction <- sbtabfile$Reaction %>% rename(Modifiers = Modifier)
  } # IsReversible? to IsReversible in Reaction table
  if("IsReversible?" %in% names(sbtabfile$Reaction)){
    sbtabfile$Reaction <- sbtabfile$Reaction %>% rename(IsReversible = `IsReversible?`)
  } # IsConstant? to Isconstant in Species table
  if("IsConstant?" %in% names(sbtabfile$Species)){
    sbtabfile$Species <- sbtabfile$Species %>% rename(IsConstant = `IsConstant?`)
  } # remove Symbol from Species table
  if("Symbol" %in% names(sbtabfile$Species)){
    sbtabfile$Species <- sbtabfile$Species[names(sbtabfile$Species) != "Symbol"]
  } # remove Type from Compartment table
  if("Type" %in% names(sbtabfile$Compartment)){
    sbtabfile$Compartment <- sbtabfile$Compartment[names(sbtabfile$Compartment) != "Type"]
  } # remove SBOTerm from Compartment table
  if("SBOTerm" %in% names(sbtabfile$Compartment)){
    sbtabfile$Compartment <- sbtabfile$Compartment[names(sbtabfile$Compartment) != "SBOTerm"]
  }
  # print names of tables
  print(paste("Project contains tabs:", names(sbtabfile)))
  {# make sure all columns start with uppercase letter
    colnames(sbtabfile[[name]]) <-
      gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2",
           colnames(sbtabfile[[name]]),
           perl = TRUE)
  }
  # Make the sbtab file
  sbtabdoc <- write_sbtab(sbtabfile, documentname)
  # Make the sbml file
  sbml_string <- write_sbml(sbtabfile)
  sbmldoc <- write_xml(sbml_string, "physmap.xml")
}
