#' 
#' \code{wildLifeStrikeDataSetSplitByYear} splits the strike data 
#' into RDS files by year, so that the data files would be aligned
#' across the different data sets
#' 
#' @examples 
#' wildLifeStrikeDataSetSplitByYear()
#' 
wildLifeStrikeDataSetSplitByYear <- function() {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                       "_Animal_Strikes.rds",
                       sep = "")
  
    RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
    
    if (file.exists(RDSFile) != TRUE){

      if (exists("sr_1990_1999") != TRUE){

        message("Reading sr_1990_1999")
        
        variableName <- "sr_1990_1999"

        assign(variableName,
               data.table(
                 read.csv(
                   paste(
                     dataDir,
                     "/STRIKE_REPORTS (1990-1999).csv",
                     sep=""),
                   header = FALSE)),
               envir = .GlobalEnv)

        names(sr_1990_1999) <- c("INDEX_NR",
                                 "OPID",
                                 "OPERATOR",
                                 "ATYPE",
                                 "AMA",
                                 "AMO",
                                 "EMA",
                                 "EMO",
                                 "AC_CLASS",
                                 "AC_MASS",
                                 "NUM_ENGS",
                                 "TYPE_ENG",
                                 "ENG_1_POS",
                                 "ENG_2_POS",
                                 "ENG_3_POS",
                                 "ENG_4_POS",
                                 "REG",
                                 "FLT",
                                 "REMAINS_COLLECTED",
                                 "REMAINS_SENT",
                                 "INCIDENT_DATE",
                                 "INCIDENT_MONTH",
                                 "INCIDENT_YEAR",
                                 "TIME_OF_DAY",
                                 "TIME",
                                 "AIRPORT_ID",
                                 "AIRPORT",
                                 "STATE",
                                 "FAAREGION",
                                 "ENROUTE",
                                 "RUNWAY",
                                 "LOCATION",
                                 "HEIGHT",
                                 "SPEED",
                                 "DISTANCE",
                                 "PHASE_OF_FLT",
                                 "DAMAGE",
                                 "STR_RAD",
                                 "DAM_RAD",
                                 "STR_WINDSHLD",
                                 "DAM_WINDSHLD",
                                 "STR_NOSE",
                                 "DAM_NOSE",
                                 "STR_ENG1",
                                 "DAM_ENG1",
                                 "STR_ENG2",
                                 "DAM_ENG2",
                                 "STR_ENG3",
                                 "DAM_ENG3",
                                 "STR_ENG4",
                                 "DAM_ENG4",
                                 "INGESTED",
                                 "STR_PROP",
                                 "DAM_PROP",
                                 "STR_WING_ROT",
                                 "DAM_WING_ROT",
                                 "STR_FUSE",
                                 "DAM_FUSE",
                                 "STR_LG",
                                 "DAM_LG",
                                 "STR_TAIL",
                                 "DAM_TAIL",
                                 "STR_LGHTS",
                                 "DAM_LGHTS",
                                 "STR_OTHER",
                                 "DAM_OTHER",
                                 "OTHER_SPECIFY",
                                 "EFFECT",
                                 "EFFECT_OTHER",
                                 "SKY",
                                 "PRECIP",
                                 "SPECIES_ID",
                                 "SPECIES",
                                 "BIRDS_SEEN",
                                 "BIRDS_STRUCK",
                                 "SIZE",
                                 "WARNED",
                                 "COMMENTS",
                                 "REMARKS",
                                 "AOS",
                                 "COST_REPAIRS",
                                 "COST_OTHER",
                                 "COST_REPAIRS_INFL_ADJ",
                                 "COST_OTHER_INFL_ADJ",
                                 "REPORTED_NAME",
                                 "REPORTED_TITLE",
                                 "REPORTED_DATE",
                                 "SOURCE",
                                 "PERSON",
                                 "NR_INJURIES",
                                 "NR_FATALITIES",
                                 "LUPDATE",
                                 "TRANSFER",
                                 "INDICATED_DAMAGE")
      } 

      if (exists("sr_2000_2009") != TRUE){
        
        message("Reading sr_2000_2009")
        
        variableName <- "sr_2000_2009"
        
        assign(variableName,
               data.table(
                 read.csv(
                   paste(
                     dataDir,
                     "/STRIKE_REPORTS (2000-2009).csv",
                     sep=""),
                   header = FALSE)),
               envir = .GlobalEnv)
        
        names(sr_2000_2009) <- c("INDEX_NR",
                                 "OPID",
                                 "OPERATOR",
                                 "ATYPE",
                                 "AMA",
                                 "AMO",
                                 "EMA",
                                 "EMO",
                                 "AC_CLASS",
                                 "AC_MASS",
                                 "NUM_ENGS",
                                 "TYPE_ENG",
                                 "ENG_1_POS",
                                 "ENG_2_POS",
                                 "ENG_3_POS",
                                 "ENG_4_POS",
                                 "REG",
                                 "FLT",
                                 "REMAINS_COLLECTED",
                                 "REMAINS_SENT",
                                 "INCIDENT_DATE",
                                 "INCIDENT_MONTH",
                                 "INCIDENT_YEAR",
                                 "TIME_OF_DAY",
                                 "TIME",
                                 "AIRPORT_ID",
                                 "AIRPORT",
                                 "STATE",
                                 "FAAREGION",
                                 "ENROUTE",
                                 "RUNWAY",
                                 "LOCATION",
                                 "HEIGHT",
                                 "SPEED",
                                 "DISTANCE",
                                 "PHASE_OF_FLT",
                                 "DAMAGE",
                                 "STR_RAD",
                                 "DAM_RAD",
                                 "STR_WINDSHLD",
                                 "DAM_WINDSHLD",
                                 "STR_NOSE",
                                 "DAM_NOSE",
                                 "STR_ENG1",
                                 "DAM_ENG1",
                                 "STR_ENG2",
                                 "DAM_ENG2",
                                 "STR_ENG3",
                                 "DAM_ENG3",
                                 "STR_ENG4",
                                 "DAM_ENG4",
                                 "INGESTED",
                                 "STR_PROP",
                                 "DAM_PROP",
                                 "STR_WING_ROT",
                                 "DAM_WING_ROT",
                                 "STR_FUSE",
                                 "DAM_FUSE",
                                 "STR_LG",
                                 "DAM_LG",
                                 "STR_TAIL",
                                 "DAM_TAIL",
                                 "STR_LGHTS",
                                 "DAM_LGHTS",
                                 "STR_OTHER",
                                 "DAM_OTHER",
                                 "OTHER_SPECIFY",
                                 "EFFECT",
                                 "EFFECT_OTHER",
                                 "SKY",
                                 "PRECIP",
                                 "SPECIES_ID",
                                 "SPECIES",
                                 "BIRDS_SEEN",
                                 "BIRDS_STRUCK",
                                 "SIZE",
                                 "WARNED",
                                 "COMMENTS",
                                 "REMARKS",
                                 "AOS",
                                 "COST_REPAIRS",
                                 "COST_OTHER",
                                 "COST_REPAIRS_INFL_ADJ",
                                 "COST_OTHER_INFL_ADJ",
                                 "REPORTED_NAME",
                                 "REPORTED_TITLE",
                                 "REPORTED_DATE",
                                 "SOURCE",
                                 "PERSON",
                                 "NR_INJURIES",
                                 "NR_FATALITIES",
                                 "LUPDATE",
                                 "TRANSFER",
                                 "INDICATED_DAMAGE")
      } 

      if (exists("sr_2010_Current") != TRUE){
        
        message("Reading sr_2010_Current")
        
        variableName <- "sr_2010_Current"
        
        assign(variableName,
               data.table(
                 read.csv(
                   paste(
                     dataDir,
                     "/STRIKE_REPORTS (2010-Current).csv",
                     sep=""),
                   header = FALSE)),
               envir = .GlobalEnv)
        
        names(sr_2010_Current) <- c("INDEX_NR",
                                 "OPID",
                                 "OPERATOR",
                                 "ATYPE",
                                 "AMA",
                                 "AMO",
                                 "EMA",
                                 "EMO",
                                 "AC_CLASS",
                                 "AC_MASS",
                                 "NUM_ENGS",
                                 "TYPE_ENG",
                                 "ENG_1_POS",
                                 "ENG_2_POS",
                                 "ENG_3_POS",
                                 "ENG_4_POS",
                                 "REG",
                                 "FLT",
                                 "REMAINS_COLLECTED",
                                 "REMAINS_SENT",
                                 "INCIDENT_DATE",
                                 "INCIDENT_MONTH",
                                 "INCIDENT_YEAR",
                                 "TIME_OF_DAY",
                                 "TIME",
                                 "AIRPORT_ID",
                                 "AIRPORT",
                                 "STATE",
                                 "FAAREGION",
                                 "ENROUTE",
                                 "RUNWAY",
                                 "LOCATION",
                                 "HEIGHT",
                                 "SPEED",
                                 "DISTANCE",
                                 "PHASE_OF_FLT",
                                 "DAMAGE",
                                 "STR_RAD",
                                 "DAM_RAD",
                                 "STR_WINDSHLD",
                                 "DAM_WINDSHLD",
                                 "STR_NOSE",
                                 "DAM_NOSE",
                                 "STR_ENG1",
                                 "DAM_ENG1",
                                 "STR_ENG2",
                                 "DAM_ENG2",
                                 "STR_ENG3",
                                 "DAM_ENG3",
                                 "STR_ENG4",
                                 "DAM_ENG4",
                                 "INGESTED",
                                 "STR_PROP",
                                 "DAM_PROP",
                                 "STR_WING_ROT",
                                 "DAM_WING_ROT",
                                 "STR_FUSE",
                                 "DAM_FUSE",
                                 "STR_LG",
                                 "DAM_LG",
                                 "STR_TAIL",
                                 "DAM_TAIL",
                                 "STR_LGHTS",
                                 "DAM_LGHTS",
                                 "STR_OTHER",
                                 "DAM_OTHER",
                                 "OTHER_SPECIFY",
                                 "EFFECT",
                                 "EFFECT_OTHER",
                                 "SKY",
                                 "PRECIP",
                                 "SPECIES_ID",
                                 "SPECIES",
                                 "BIRDS_SEEN",
                                 "BIRDS_STRUCK",
                                 "SIZE",
                                 "WARNED",
                                 "COMMENTS",
                                 "REMARKS",
                                 "AOS",
                                 "COST_REPAIRS",
                                 "COST_OTHER",
                                 "COST_REPAIRS_INFL_ADJ",
                                 "COST_OTHER_INFL_ADJ",
                                 "REPORTED_NAME",
                                 "REPORTED_TITLE",
                                 "REPORTED_DATE",
                                 "SOURCE",
                                 "PERSON",
                                 "NR_INJURIES",
                                 "NR_FATALITIES",
                                 "LUPDATE",
                                 "TRANSFER",
                                 "INDICATED_DAMAGE")
      } 
      
      #STRIKE_REPORTS_BASH --> contains only military data, not required

      
      if (i >= 1990 && i <= 1999) {
        dataOfWholeYear <- sr_1990_1999[INCIDENT_YEAR == i]
      }
      else if (i >= 2000 && i <= 2009) {
        dataOfWholeYear <- sr_2000_2009[INCIDENT_YEAR == i]
      }
      else if (i >= 2010 && i <= 2019) {
        dataOfWholeYear <- sr_2010_Current[INCIDENT_YEAR == i]
      }

      saveRDS(dataOfWholeYear, file = RDSFile)
      message(RDSFileName," created.")
      
      #free up memory
      rm(dataOfWholeYear)
      gc()
      
    }
    else {
      message(RDSFileName,
              " exists, no further action is required.")
    }
    
  
  } #end of "for (i in startYear:endYear)"

}
