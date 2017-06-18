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
    
    help(glm)
    
    hist(modelData$OriginCount)
    hist(modelData$OriginMaxDistance)
    hist(modelData$OriginMinDistance)
    hist(modelData$OriginAvgDistance)
    hist(modelData$DestinationCount)
    hist(modelData$DestinationMaxDistance)
    hist(modelData$DestinationMinDistance)
    hist(modelData$DestinationAvgDistance)
    
    hist(log10(modelData$OriginCount))
    hist(log(modelData$OriginCount))
    
    model01 <- lm(StrikeNo ~ 
                    State +
                    OriginCount +
                    OriginMaxDistance +
                    OriginMinDistance +
                    OriginAvgDistance +
                    DestinationCount +
                    DestinationMaxDistance + 
                    DestinationMinDistance + 
                    DestinationAvgDistance
                  , data = modelData)
    summary(model01)

    
    model01 <- lm(StrikeNo ~ 
                    log10(OriginCount) +
                    log10(DestinationCount)
                  , data = modelData)
    summary(model01)
    
    
    gvlma(model01)

    model02 <- glm(StrikeNo ~ 
                    OriginCount +
                    OriginMaxDistance +
                    OriginMinDistance +
                    OriginAvgDistance +
                    DestinationCount +
                    DestinationMaxDistance + 
                    DestinationMinDistance + 
                    DestinationAvgDistance
                  , data = modelData
                  , family = gaussian)
    summary(model02)
    
    
    
    plot(StrikeNo ~ OriginCount, data = modelData)
    abline(model01, col = "red")

  } #end of "if (file.exists(RDSFile) != TRUE)"
  
}

# "LocationID",
# "Region",
# "State",
# "City",
# "FacilityName",
# "OriginCount",
# "OriginMaxDistance",
# "OriginMinDistance",
# "OriginAvgDistance",
# "DestinationCount",
# "DestinationMaxDistance",
# "DestinationMinDistance",
# "DestinationAvgDistance",
# "StrikeNo"
