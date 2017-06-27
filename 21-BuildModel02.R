#' 
#' \code{BuildModel02} builds the second model
#' 
#' @examples 
#' BuildModel02()
#' 
BuildModel02 <- function() {
  
  dataDir <- getDataDir()
  set.seed(42)
  
  RDSFileName <- "12_Model_02_Data.rds"
  RDSFile <- paste(dataDir,
                   "/",
                   RDSFileName,
                   sep = "")

  if (file.exists(RDSFile) != TRUE) {
    message(RDSFileName,
            " is not available, ",
            "please re-run the preparation scripts!")
  } else {

    #read the data for model building
    trainData <- readRDS(file = RDSFile)

    #start H2O
    h2o.init(
      nthreads=-1,
      max_mem_size = "5G"
    )
    
    #clenaup the cluster
    h2o.removeAll()
    
    #upload the data to H2O
    trainDataH2O <- as.h2o(trainData)
    
    #remove the data object
    rm(trainData)
    gc()
    
    #create test and train sets
    splits <- h2o.splitFrame(
      trainDataH2O,
      c(0.6,0.2),
      seed=42)
    
    #data sets
    trainH2O <- h2o.assign(splits[[1]], "train.hex")   
    validH2O <- h2o.assign(splits[[2]], "valid.hex")
    testH2O <- h2o.assign(splits[[3]], "test.hex")
    
    #train the initial model
    trainedModelInit <- h2o.gbm(
      training_frame = trainH2O,
      validation_frame = validH2O,
      x=1:15,
      y=16,
      seed = 42)
    
    #summary(trainedModelInit)
    
    ColumnNames <- c("Quarter",
                     "Month",
                     "DayofMonth",
                     "DayOfWeek",
                     "UniqueCarrier",
                     "FlightNum",
                     "Origin",
                     "Dest",
                     "DepTimeBlk",
                     "ArrTimeBlk",
                     "CRSElapsedTime",
                     "Distance",
                     "DistanceGroup")
    
    #train the model
    trainedModel <- h2o.gbm(
      training_frame = trainH2O,
      validation_frame = validH2O,
      x = ColumnNames,
      y = 16,
      ntrees = 200,
      learn_rate = 0.2,
      max_depth = 10,
      stopping_rounds = 2,
      stopping_metric = "logloss",
      stopping_tolerance = 0.01,
      score_each_iteration = T,
      seed = 42)

    #summary(trainedModel)

    #save the model
    model_path_init <- 
      h2o.saveModel(object=trainedModelInit, 
                    path=getDataDir(), 
                    force=TRUE)
    RDSFileName <- "13_Model_02_Path_Init.rds"
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
    saveRDS(model_path_init, file = RDSFile)
    
    
    model_path <- 
      h2o.saveModel(object=trainedModel, 
                    path=getDataDir(), 
                    force=TRUE)
    RDSFileName <- "14_Model_02_Path.rds"
    RDSFile <- paste(dataDir,
                     "/",
                     RDSFileName,
                     sep = "")
    saveRDS(model_path, file = RDSFile)

    
    #load the model
    # #RDSFileName <- "13_Model_02_Path_Init.rds"
    # #RDSFileName <- "14_Model_02_Path.rds"
    # RDSFile <- paste(dataDir,
    #                  "/",
    #                  RDSFileName,
    #                  sep = "")
    # model_path <- readRDS(file = RDSFile)
    # saved_model <- h2o.loadModel(model_path)
    
    
    #final scoring
    # perf <- 
    #   h2o.performance(model = saved_model,
    #                   newdata = testH2O)
    
    #create the confusion matrix for the scored data
    # h2o.confusionMatrix(perf)
    
    h2o.shutdown(prompt = FALSE)

  } # end of "if (file.exists(RDSModelFile) != TRUE)"

}
