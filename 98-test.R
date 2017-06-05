source("90-UserDefinedFunctions.R")
suppressPackageStartupMessages(loadLibraries())
suppressPackageStartupMessages(readConfigFile(TRUE))

  dataDir <- getDataDir()
  startYear <- getStartYear()
  endYear <- getEndYear()

i <- 1990
    RDSFileName <- paste(i,
                         "_Animal_Strikes.rds",
                         sep = "")
    
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
    
    variableName <- paste("AS_", i, sep="")
    assign(variableName, readRDS(file = RDSFile))
    #DataField <- "AC_CLASS"
    DataField <- "TIME_OF_DAY"
    DataYear <- i

    ggplot(data = get(variableName), aes(get(DataField))) +
      ggtitle(paste("Data distribution of ",DataField," in year ", DataYear, sep="")) +
      geom_bar() +
      coord_flip() + 
      xlab("") + 
      ylab("")
    
    
    +
      theme(axis.text.y = element_text(angle = 90, hjust = 1))
      opts(title=) 
    




