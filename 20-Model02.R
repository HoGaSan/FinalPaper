#' 
#' \code{BuildModel02Data} builds data the second model
#' 
#' @examples 
#' BuildModel02Data()
#' 
BuildModel02Data <- function() {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()
  set.seed(42)
  
  trainDataFull <- data.table(
    Year = integer(),
    Quarter = integer(),
    Month = integer(),
    DayofMonth = integer(),
    DayOfWeek = integer(),
    FlightDate = factor(),
    UniqueCarrier = factor(),
    FlightNum = integer(),
    Origin = factor(),
    Dest = factor(),
    DepTimeBlk = factor(),
    ArrTimeBlk = factor(),
    CRSElapsedTime = numeric(),
    Distance = numeric(),
    DistanceGroup = factor(),
    strikeFlag = factor()
  )

  for (i in startYear:endYear){
    RDSModelFileName <- paste(i,
                              "_On_Time_On_Time_Performance_05_Mod.rds",
                              sep = "")
    
    RDSModelFile <- paste(dataDir,
                          "/",
                          RDSModelFileName,
                          sep = "")

    if (file.exists(RDSModelFile) != TRUE) {
      message(RDSModelFileName,
              " is not available, ",
              "please re-run the preparation scripts!")
    } else {

      trainData <- readRDS(file = RDSModelFile)
      
      #take only the striked data
      trainDataStriked <- 
        trainData[strikeFlag == "1",]
      #boost the number of striked data
      trainDataStriked <- 
        trainDataStriked[rep(1:.N, each = 3)]
      
      #take only the unstriked data
      trainDataNonStriked <- 
        trainData[strikeFlag == "0",]
      #take only 1% of the original data amount      
      trainDataNonStriked <- 
        trainDataNonStriked[sample(.N,round(.N*0.1))]
      
      #merge the reduced and boosted data tables
      trainData <- rbindlist(
        list(
          trainDataStriked,
          trainDataNonStriked
        )
      )
      
      #set the required column names
      ColumnNames <- c("Year",
                       "Quarter",
                       "Month",
                       "DayofMonth",
                       "DayOfWeek",
                       "FlightDate",
                       "UniqueCarrier",
                       "FlightNum",
                       "Origin",
                       "Dest",
                       "DepTimeBlk",
                       "ArrTimeBlk",
                       "CRSElapsedTime",
                       "Distance",
                       "DistanceGroup",
                       "strikeFlag")
      
      #Move reduces data into a new data set
      trainData <- trainData[, ..ColumnNames]
      
      #merge striked and unstriked data
      trainDataFull <- rbindlist(
          list(
            trainDataFull,
            trainData
          )
        )
      
      
      #free memory
      rm(trainData)
      rm(trainDataStriked)
      rm(trainDataNonStriked)
      gc()

    } # end of "if (file.exists(RDSModelFile) != TRUE)"
  } #end of "for (i in startYear:endYear)"
  
  #Resetting the factors of the data tables
  trainDataFull[] <- 
    lapply(trainDataFull,
           function(x) if(is.factor(x)) factor(x) else x)
  
  
  #save the data for modeling
  RDSFileName <- "12_Model_02_Data.rds"
  RDSFile <- paste(dataDir,
                          "/",
                          RDSFileName,
                          sep = "")
  
  saveRDS(trainDataFull, file = RDSFile)

}
