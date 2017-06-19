#' 
#' \code{BuildModel01} builds the first model
#' 
#' @examples 
#' BuildModel01()
#' 
BuildModel01 <- function() {
  
  dataDir <- getDataDir()
  
  RDSFileName <- "09_Model_01_Data.rds"
  
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")
  
  if (file.exists(RDSFile) != TRUE) {
    message(RDSFileName,
            " is not available, ",
            "please re-run the preparation scripts!")
  } else {
    
    modelData <- readRDS(file = RDSFile)
    
    modelData <- modelData[StrikeNo > 0]
    modelData <- modelData[LandAreaCoveredByAirport > 0]
    modelData <- modelData[ARPElevation > 0]

    #Create the histograms
    binSize <- (max(modelData$StrikeNo) - 
                  min(modelData$StrikeNo))/10
    saveModelingHistogramPNG(FieldName =  "StrikeNo",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$OriginCount) - 
                  min(modelData$OriginCount))/10
    saveModelingHistogramPNG(FieldName =  "OriginCount",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$OriginMaxDistance) - 
                  min(modelData$OriginMaxDistance))/10
    saveModelingHistogramPNG(FieldName =  "OriginMaxDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$OriginMinDistance) - 
                  min(modelData$OriginMinDistance))/10
    saveModelingHistogramPNG(FieldName =  "OriginMinDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$OriginAvgDistance) - 
                  min(modelData$OriginAvgDistance))/10
    saveModelingHistogramPNG(FieldName =  "OriginAvgDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$DestinationCount) - 
                  min(modelData$DestinationCount))/10
    saveModelingHistogramPNG(FieldName =  "DestinationCount",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$DestinationMaxDistance) - 
                  min(modelData$DestinationMaxDistance))/10
    saveModelingHistogramPNG(FieldName =  "DestinationMaxDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$DestinationMinDistance) - 
                  min(modelData$DestinationMinDistance))/10
    saveModelingHistogramPNG(FieldName =  "DestinationMinDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$DestinationAvgDistance) - 
                  min(modelData$DestinationAvgDistance))/10
    saveModelingHistogramPNG(FieldName =  "DestinationAvgDistance",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$ARPElevation) - 
                  min(modelData$ARPElevation))/10
    saveModelingHistogramPNG(FieldName =  "ARPElevation",
                             DataObject = modelData,
                             BinSize = binSize)
    
    binSize <- (max(modelData$LandAreaCoveredByAirport) - 
                  min(modelData$LandAreaCoveredByAirport))/10
    saveModelingHistogramPNG(FieldName =  "LandAreaCoveredByAirport",
                             DataObject = modelData,
                             BinSize = binSize)
    
    modelDataLog <- modelData[]
    
    modelDataLog[] <- 
      lapply(modelDataLog,
             function(x) if(is.numeric(x)) log(x) else x)

    modelDataLog[] <- 
      lapply(modelDataLog,
             function(x) if(is.integer(x)) log(x) else x)
    
    #Create the histograms of the log values
    binSize <- (max(modelDataLog$StrikeNo) - 
                  min(modelDataLog$StrikeNo))/10
    saveModelingHistogramLogPNG(FieldName =  "StrikeNo",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$OriginCount) - 
                  min(modelDataLog$OriginCount))/10
    saveModelingHistogramLogPNG(FieldName =  "OriginCount",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$OriginMaxDistance) - 
                  min(modelDataLog$OriginMaxDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "OriginMaxDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$OriginMinDistance) - 
                  min(modelDataLog$OriginMinDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "OriginMinDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$OriginAvgDistance) - 
                  min(modelDataLog$OriginAvgDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "OriginAvgDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$DestinationCount) - 
                  min(modelDataLog$DestinationCount))/10
    saveModelingHistogramLogPNG(FieldName =  "DestinationCount",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$DestinationMaxDistance) - 
                  min(modelDataLog$DestinationMaxDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "DestinationMaxDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$DestinationMinDistance) - 
                  min(modelDataLog$DestinationMinDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "DestinationMinDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$DestinationAvgDistance) - 
                  min(modelDataLog$DestinationAvgDistance))/10
    saveModelingHistogramLogPNG(FieldName =  "DestinationAvgDistance",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$ARPElevation) - 
                  min(modelDataLog$ARPElevation))/10
    saveModelingHistogramLogPNG(FieldName =  "ARPElevation",
                                DataObject = modelDataLog,
                                BinSize = binSize)
    
    binSize <- (max(modelDataLog$LandAreaCoveredByAirport) - 
                  min(modelDataLog$LandAreaCoveredByAirport))/10
    saveModelingHistogramLogPNG(FieldName =  "LandAreaCoveredByAirport",
                                DataObject = modelDataLog,
                                BinSize = binSize)

    #Creating the models
    
    RDSFileNameM1 <- "10_Model_01_01.rds"
    RDSFileM1 <- paste(dataDir,
                     "/",
                     RDSFileNameM1,
                     sep = "")
    
    model01 <- lm(StrikeNo ~ 
                    OriginCount +
                    DestinationCount
                  , data = modelDataLog)
    
    saveRDS(model01, file = RDSFileM1)
    
    
    RDSFileNameM2 <- "10_Model_01_02.rds"
    RDSFileM2 <- paste(dataDir,
                       "/",
                       RDSFileNameM2,
                       sep = "")

    model02 <- lm(StrikeNo ~ 
                    OriginCount +
                    OriginMaxDistance +
                    OriginMinDistance +
                    OriginAvgDistance +
                    DestinationCount +
                    DestinationMaxDistance + 
                    DestinationMinDistance + 
                    DestinationAvgDistance
                  , data = modelData)

    saveRDS(model02, file = RDSFileM2)
    

    RDSFileNameM3 <- "10_Model_01_03.rds"
    RDSFileM3 <- paste(dataDir,
                       "/",
                       RDSFileNameM3,
                       sep = "")
    
    model03 <- lm(StrikeNo ~ 
                    ARPElevation +
                    LandAreaCoveredByAirport
                  , data = modelData)
    
    saveRDS(model03, file = RDSFileM3)
    

    RDSFileNameM4 <- "10_Model_01_04.rds"
    RDSFileM4 <- paste(dataDir,
                       "/",
                       RDSFileNameM4,
                       sep = "")
    
    model04 <- lm(StrikeNo ~ 
                    Region
                  , data = modelData)
    
    saveRDS(model04, file = RDSFileM4)
    
    RDSFileNameM5 <- "10_Model_01_05.rds"
    RDSFileM5 <- paste(dataDir,
                       "/",
                       RDSFileNameM5,
                       sep = "")
    
    model05 <- lm(StrikeNo ~ 
                    Region +
                    State
                  , data = modelData)
    
    saveRDS(model05, file = RDSFileM5)
    

    RDSFileNameM6 <- "10_Model_01_06.rds"
    RDSFileM6 <- paste(dataDir,
                       "/",
                       RDSFileNameM6,
                       sep = "")
    
    model06 <- lm(StrikeNo ~ 
                    State + 
                    OriginCount +
                    DestinationCount +
                    ARPElevation +
                    LandAreaCoveredByAirport
                  , data = modelData)
    
    saveRDS(model06, file = RDSFileM6)
    
  } #end of "if (file.exists(RDSFile) != TRUE)"
  
}
