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

  airportAttributes <- data.table(
    #FAA Location ID of the airport:
    airportCode = character(),
    #FAA Name of the airport:
    airportName = character(),
    #average number of flights originated from the airport:
    avgOriginated = integer(),
    #average number of flights departed at the airport:
    avgDeparted = integer(),
    #the maximum distance of the flights originated by the airport:
    maxDistanceOriginated = integer(),
    #the maximum distance of the flights departed at the airport:
    maxDistanceDeparted = integer(),
    #the average distance of the flights originated by the airport:
    avgDistanceOriginated = integer(),
    #the average distance of the flights departed at the airport:
    avgDistanceDeparted = integer(),
    #the minimum distance of the flights originated by the airport:
    minDistanceOriginated = integer(),
    #the minimum distance of the flights departed at the airport:
    minDistanceDeparted = integer(),
    #the number of strikes at the airport:
    strikeNo = integer(),
    #the number of strikes in the flight phase landing roll:
    strikeNoFp_LR = integer(),
    #the number of strikes in the flight phase descent:
    strikeNoFp_D = integer(),
    #the number of strikes in the flight phase climb:
    strikeNoFp_C = integer(),
    #the number of strikes in the flight phase taxi:
    strikeNoFp_T = integer(),
    #the number of strikes in the flight phase take-off run:
    strikeNoFp_ToR = integer(),
    #the number of strikes in the flight phase approach:
    strikeNoFp_Ap = integer(),
    #the number of strikes in the flight phase local:
    strikeNoFp_L = integer(),
    #the number of strikes in the flight phase parked:
    strikeNoFp_P = integer(),
    #the number of strikes in the flight phase arrival:
    strikeNoFp_Ar = integer(),
    #the number of strikes in the flight phase departure:
    strikeNoFp_Dep = integer(),
    #the number of strikes in the flight phase other (aka NONE):
    strikeNoFp_O = integer(),
    #the number of strikes by the time of day dawn:
    strikeNoToD_Dawn = integer(),
    #the number of strikes by the time of day day:
    strikeNoToD_Day = integer(),
    #the number of strikes by the time of day dusk:
    strikeNoToD_Dusk = integer(),
    #the number of strikes by the time of day night:
    strikeNoToD_Night = integer(),
    #the number of strikes by the time of day other (aka NONE):
    strikeNoToD_O = integer(),
    #the number of strikes by the sky condition no clouds:
    strikeNoS_NC = integer(),
    #the number of strikes by the sky condition some clouds:
    strikeNoS_SC = integer(),
    #the number of strikes by the sky condition overcast:
    strikeNoS_OV = integer(),
    #the number of strikes by the sky condition other (aka NONE):
    strikeNoS_O = integer(),
    #the number of strikes by the precipitation rain:
    strikeNoP_R = integer(),
    #the number of strikes by the precipitation snow:
    strikeNoP_S = integer(),
    #the number of strikes by the precipitation rain and snow:
    strikeNoP_RS = integer(),
    #the number of strikes by the precipitation fog:
    strikeNoP_F = integer(),
    #the number of strikes by the precipitation fog and snow:
    strikeNoP_FS = integer(),
    #the number of strikes by the precipitation fog and rain:
    strikeNoP_FR = integer(),
    #the number of strikes by the precipitation fog, rain and snow:
    strikeNoP_FRS = integer(),
    #the number of strikes by the precipitation other (aka NONE):
    strikeNoP_O = integer()
  )

  airportAttributesByYear <- data.table(
    airportCode = character(),
    airportName = character(),
    dataYear = character(),
    Originated = integer(),
    Departed = integer(),
    maxDistanceOriginated = integer(),
    maxDistanceDeparted = integer(),
    minDistanceOriginated = integer(),
    minDistanceDeparted = integer(),
    sumDistanceOriginated = integer(),
    sumDistanceDeparted = integer(),
    strikeNo = integer(),
    strikeNoFp_LR = integer(),
    strikeNoFp_D = integer(),
    strikeNoFp_C = integer(),
    strikeNoFp_T = integer(),
    strikeNoFp_ToR = integer(),
    strikeNoFp_Ap = integer(),
    strikeNoFp_L = integer(),
    strikeNoFp_P = integer(),
    strikeNoFp_Ar = integer(),
    strikeNoFp_Dep = integer(),
    strikeNoFp_O = integer(),
    strikeNoToD_Dawn = integer(),
    strikeNoToD_Day = integer(),
    strikeNoToD_Dusk = integer(),
    strikeNoToD_Night = integer(),
    strikeNoToD_O = integer(),
    strikeNoS_NC = integer(),
    strikeNoS_SC = integer(),
    strikeNoS_OV = integer(),
    strikeNoS_O = integer(),
    strikeNoP_R = integer(),
    strikeNoP_S = integer(),
    strikeNoP_RS = integer(),
    strikeNoP_F = integer(),
    strikeNoP_FS = integer(),
    strikeNoP_FR = integer(),
    strikeNoP_FRS = integer(),
    strikeNoP_O = integer()
  )
  
  for (i in startYear:endYear){
    RDSFileName <- paste(i,
                         "_On_Time_On_Time_Performance_04_Cle.rds",
                         sep = "")

    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")

    if (file.exists(RDSFile) != TRUE){
      message(RDSFileName,
              "is not available, ",
              "please re-run the preparation scripts!")
    } else {
      
      #Read the data file into a variable
      variableName <- paste("FP_", i, sep="")
      assign(variableName, readRDS(file = RDSFile))
      
      dataSet <- get(variableName)
      
      
      airportAttributesByYear[,
                              c("airportCode", 
                                "dataYear",
                                "Originated",
                                "maxDistanceOriginated",
                                "minDistanceOriginated",
                                "sumDistanceOriginated"
                                )
                              ] <- dataSet[,
                                           .(.N,
                                             max(Distance),
                                             min(Distance),
                                             sum(Distance)),
                                           by = c("Origin",
                                                  "Year")
                                           ]
      
      airportAttributesByYear[,
                              c("airportCode", 
                                "dataYear",
                                "Departed",
                                "maxDistanceDeparted",
                                "minDistanceDeparted",
                                "sumDistanceDeparted"
                              )
                              ] <- dataSet[,
                                           .(.N,
                                             max(Distance),
                                             min(Distance),
                                             sum(Distance)),
                                           by = c("Dest",
                                                  "Year")
                                           ]

      # #Get the number of flights, minimum, maximum and summary distances
      # DT1 <- dataSet[, 
      #                .(.N,
      #                  max(Distance),
      #                  min(Distance),
      #                  sum(Distance)), 
      #                by = c("Origin", "Year")]
      # names(DT1) <- c("Airport",
      #                 "Year",
      #                 "OriginCount",
      #                 "OriginMaxDistance",
      #                 "OriginMinDistance",
      #                 "OriginSumDistance")
      # setkey(DT1, Airport, Year)
      
      # DT2 <- dataSet[, 
      #                .(.N,
      #                  max(Distance),
      #                  min(Distance),
      #                  sum(Distance)),
      #                by = c("Dest", "Year")]
      # names(DT2) <- c("Airport",
      #                 "Year",
      #                 "DestinationCount",
      #                 "DestinationMaxDistance",
      #                 "DestinationMinDistance",
      #                 "DestinationSumDistance")
      # setkey(DT2, Airport, Year)
      
      # DT3 <- DT1[DT2]
      
      
      
      
      
      
      
      # airportAttributesByYear <- rbindlist(
      #   list(
      #     airportAttributesByYear,
      #     dataSet[,]
      #     list(cleanedDataSet
      #          as.character(i),
      #          nrow(cleanedDataSet),
      #          length(levels(cleanedDataSet$Carrier)),
      #          length(levels(cleanedDataSet$Origin)),
      #          length(levels(cleanedDataSet$OriginState)),
      #          length(levels(cleanedDataSet$Dest)),
      #          length(levels(cleanedDataSet$DestState)),
      #          length(levels(cleanedDataSet$DepTimeBlk)),
      #          length(levels(cleanedDataSet$DistanceGroup))
      #          )
      #     )
      #   )
      

      #Free up the memory
      rm(list = variableName)
      rm(variableName)
      gc()
        
    } #end of "if (file.exists(RDSFile) != TRUE)"
    
  } #end of "for (i in startYear:endYear)"

  RDSAirportAttributesName <- paste("04_Airport_Attributes.rds",
                                    sep = "")
  
  RDSAirportAttributes <- paste(dataDir,
                                "/",
                                RDSAirportAttributesName,
                                sep = "")
  
  if (file.exists(RDSAirportAttributes) != TRUE) {
    saveRDS(dataSummary, file = RDSAirportAttributes)
  } else {
    file.remove(RDSAirportAttributes)
    saveRDS(dataSummary, file = RDSAirportAttributes)
  }

}
