#' 
#' \code{DeriveAirportAttributes} created airport specific attribures 
#' based on the flight performance data set and animal strike data set
#' 
#' @examples 
#' DeriveAirportAttributes()
#' 
DeriveAirportAttributes <- function() {
  
  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

  RDSFileName <- "07_CLE_Airport.rds"
  
  RDSFile <- paste(dataDir,
                     "/",
                   RDSFileName,
                     sep = "")
  
  airportsData <- readRDS(file = RDSFile)
  
  for (i in startYear:endYear){
    
    RDSFileNameFP <- paste(i,
                         "_On_Time_On_Time_Performance_04_Cle.rds",
                         sep = "")

    RDSFileFP <- paste(dataDir,
                     "/",
                     RDSFileNameFP,
                     sep = "")

    RDSFileNameAS <- paste(i,
                           "_Animal_Strikes_04_Cle.rds",
                           sep = "")
    
    RDSFileAS <- paste(dataDir,
                       "/",
                       RDSFileNameAS,
                       sep = "")
    
    if ((file.exists(RDSFileFP) != TRUE) || 
        (file.exists(RDSFileAS) != TRUE)){
      message(RDSFileNameFP,
              " or ", 
              RDSFileNameAS,
              " is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      #Read the data file into a variable
      variableName <- paste("FP_", i, sep="")
      assign(variableName, readRDS(file = RDSFileFP))
      
      dataSet <- get(variableName)
      
      originData <- dataSet[,
                            .(.N,
                              max(Distance),
                              min(Distance),
                              sum(Distance)),
                            by = c("Origin",
                                   "Year")
                            ]
      
      names(originData) <- c("Airport",
                             "Year",
                             "OriginCount",
                             "OriginMaxDistance",
                             "OriginMinDistance",
                             "OriginSumDistance")
      
      setkey(originData, Airport, Year)
      
      destData <- dataSet[,
                          .(.N,
                            max(Distance),
                            min(Distance),
                            sum(Distance)),
                          by = c("Dest",
                                 "Year")
                          ]
      
      names(destData) <- c("Airport",
                           "Year",
                           "DestinationCount",
                           "DestinationMaxDistance",
                           "DestinationMinDistance",
                           "DestinationSumDistance")
      
      setkey(destData, Airport, Year)
      
      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      rm(dataSet)
      gc()
      
      #Read the data file into a variable
      variableName <- paste("AS_", i, sep="")
      assign(variableName, readRDS(file = RDSFileAS))
      
      dataSet <- get(variableName)
      
      strikeData <- dataSet[,
                            .(.N),
                            by = c("AIRPORT_ID",
                                   "INCIDENT_YEAR")
                            ]
      
      names(strikeData) <- c("Airport",
                             "Year",
                             "StrikeNo")
      
      strikeData$Airport <- 
        airportsData[IcaoIdentifier %in% strikeData$Airport, 
                     LocationID]

      setkey(strikeData, Airport, Year)
      
      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      rm(dataSet)
      gc()
      
      
      if (i == startYear){
        
        originDataFull <- originData
        destDataFull <- destData
        strikeDataFull <- strikeData
        
      } else {
        
        originDataFull <- rbindlist(
          list(
            originDataFull,
            originData),
          fill = TRUE
        )
        
        destDataFull <- rbindlist(
          list(
            destDataFull,
            destData),
          fill = TRUE
        )
        
        strikeDataFull <- rbindlist(
          list(
            strikeDataFull,
            strikeData),
          fill = TRUE
        )

      }
      
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"
  
  summedData <-
    originDataFull[,.(
      sum(OriginCount),
      max(OriginMaxDistance),
      min(OriginMinDistance),
      sum(OriginSumDistance)/sum(OriginCount)
    ),
    by = "Airport"]
  
  names(summedData) <- c("Airport",
                         "OriginCount",
                         "OriginMaxDistance",
                         "OriginMinDistance",
                         "OriginAvgDistance")
  
  #Resetting the factors of the data table
  summedData[] <- 
    lapply(summedData,
           function(x) if(is.factor(x)) factor(x) else x)
  
  RDSFileName <- paste("08_DER_Airport_Origin.rds",sep = "")
  
  RDSFile <- paste(dataDir,"/",RDSFileName,sep = "")

  if (file.exists(RDSFile) != TRUE) {
    saveRDS(summedData, file = RDSFile)
  } else {
    file.remove(RDSFile)
    saveRDS(summedData, file = RDSFile)
  }
  
  
  summedData <-
    destDataFull[,.(
      sum(DestinationCount),
      max(DestinationMaxDistance),
      min(DestinationMinDistance),
      sum(DestinationSumDistance)/sum(DestinationCount)
    ),
    by = "Airport"]
  
  names(summedData) <- c("Airport",
                       "DestinationCount",
                       "DestinationMaxDistance",
                       "DestinationMinDistance",
                       "DestinationAvgDistance")
  
  #Resetting the factors of the data table
  summedData[] <- 
    lapply(summedData,
           function(x) if(is.factor(x)) factor(x) else x)
  
  RDSFileName <- paste("08_DER_Airport_Destination.rds",sep = "")
  
  RDSFile <- paste(dataDir,"/",RDSFileName,sep = "")
  
  if (file.exists(RDSFile) != TRUE) {
    saveRDS(summedData, file = RDSFile)
  } else {
    file.remove(RDSFile)
    saveRDS(summedData, file = RDSFile)
  }
  
  
  summedData <-
    strikeDataFull[,.(
      sum(StrikeNo)
    ),
    by = "Airport"]
  
  names(summedData) <- c("Airport",
                         "StrikeNo")
  
  #Resetting the factors of the data table
  summedData[] <- 
    lapply(summedData,
           function(x) if(is.factor(x)) factor(x) else x)
  
  RDSFileName <- paste("08_DER_Airport_Strike.rds",sep = "")
  
  RDSFile <- paste(dataDir,"/",RDSFileName,sep = "")
  
  if (file.exists(RDSFile) != TRUE) {
    saveRDS(summedData, file = RDSFile)
  } else {
    file.remove(RDSFile)
    saveRDS(summedData, file = RDSFile)
  }
  
}
