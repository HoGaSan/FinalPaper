#' 
#' \code{BuildModel02_01} builds the initial second model
#' 
#' @examples 
#' BuildModel02_01()
#' 
BuildModel02_01 <- function() {
  
  dataDir <- getDataDir()
  
  h2o.init()
  
  RDSModelFileName <- "1990_On_Time_On_Time_Performance_05_Mod.rds"
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
    trainDataH2O <- as.h2o(trainData)
    
    #train the model
    trainedModel <- h2o.deeplearning(x = 1:(ncol(trainDataH2O)-1),
                                     y = "strikeFlag",
                                     training_frame = trainDataH2O,
                                     nfolds = 3,
                                     activation = "Rectifier",
                                     hidden = c(20,20),
                                     epochs = 10,
                                     stopping_rounds = 3,
                                     stopping_tolerance = 0.1,
                                     stopping_metric = "AUC",
                                     seed=42)

    #Get AUC value
    #modelAUC <- h2o.auc(trainedModel)
      
    #Get model performance values
    #modelPerf <- h2o.performance(trainedModel)
      
    #free memory
    rm(trainData)
    rm(trainDataH2O)
    
  } # end of "if (file.exists(RDSModelFile) != TRUE)"
    
  h2o.shutdown(prompt = FALSE)
  
}


#' 
#' \code{BuildModel02Data} builds data the second model
#' 
#' @examples 
#' BuildModel02Data()
#' 
BuildModel02Data <- function() {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear() - 1 #2016 will be the validation data set i<-1990 i<-1995 i<-2000 i<-2005 i<-2010
  set.seed(42)
  
  trainDataFull <- data.table(
    Quarter = integer(),
    Month = integer(),
    DayofMonth = integer(),
    DayOfWeek = integer(),
    FlightDate = factor(),
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
      trainDataStriked <- trainData[strikeFlag == "1",]
      #boost the number of striked data
      trainDataStriked <- trainDataStriked[rep(1:.N, each = 3)]
      
      #take only the unstriked data
      trainDataNonStriked <- trainData[strikeFlag == "0",]
      #take only 1% of the original data amount      
      trainDataNonStriked <- trainDataNonStriked[sample(.N,round(.N*0.1))]
      
      #merge the reduced and boosted data tables
      trainData <- rbindlist(
        list(
          trainDataStriked,
          trainDataNonStriked
        )
      )
      
      #set the required column names
      ColumnNames <- c("Quarter",
                       "Month",
                       "DayofMonth",
                       "DayOfWeek",
                       "FlightDate",
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
  
  #save the data for modeling
  RDSFileName <- "12_Model_02_Data.rds"
  RDSFile <- paste(dataDir,
                          "/",
                          RDSFileName,
                          sep = "")
  
  saveRDS(trainDataFull, file = RDSFile)

}
