#' 
#' \code{DescribeAirportDataSet} re-creates the
#' inputs based on the column selection of the data 
#' verification report
#' 
#' @examples 
#' DescribeAirportDataSet()
#' 
DescribeAirportDataSet <- function() {

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  RDSFileName <- "04_ORIG_Airport.rds"

  RDSFile <- paste(dataDir,
                 "/",
                 RDSFileName,
                 sep = "")

  RDSFileNameDescibed <- "05_DESC_Airport.rds"
  
  RDSFileDescibed <- paste(dataDir,
                           "/",
                           RDSFileNameDescibed,
                           sep = "")
  
  if (file.exists(RDSFile) != TRUE){
    message(RDSFileName,
            "is not available, ",
            "please re-run the preparation scripts!")
  } else {

    if (file.exists(RDSFileDescibed) == TRUE){
      message(RDSFileNameDescibed,
              " exists, no further action is required.")
    } else {
      
      #Read the data file into a variable
      originalDataSet <- readRDS(file = RDSFile)
      
      #set the required column names
      ColumnNames <- c("Type",
                       "LocationID",
                       "Region",
                       "State",
                       "StateName",
                       "City",
                       "FacilityName",
                       "ARPLatitude",
                       "ARPLatitudeS",
                       "ARPLongitude",
                       "ARPLongitudeS",
                       "ARPElevation",
                       "LandAreaCoveredByAirport",
                       "AirportStatusCode",
                       "IcaoIdentifier"
                       )
      
      #Move reduces data into a new data set
      describedDataSet <- originalDataSet[, ..ColumnNames]
      
      saveRDS(describedDataSet, file = RDSFileDescibed)
      message(RDSFileNameDescibed,
              " created.")

    } #end of "if (file.exists(RDSFileDescibed) == TRUE)"
    
  } #end of "if (file.exists(RDSFile) != TRUE)"

}
