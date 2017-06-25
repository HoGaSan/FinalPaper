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
    h2o.init()
    
    #upload the data to H2O
    trainDataH2O <- as.h2o(trainData)
    
    #remove the data object
    rm(trainData)
    gc()
    
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
    
    #save the model
    model_path <- h2o.saveModel(object=trainedModel, path=getDataDir(), force=TRUE)
    
    
    #Get AUC value
    #modelAUC <- h2o.auc(trainedModel)
    
    #Get model performance values
    #modelPerf <- h2o.performance(trainedModel)
    
    #Get TPR and FPR from the metrics
    # modelMetrics <- dt[,c("fpr","tpr"),with=FALSE]
    # 
    # if (modelMetrics[,.N]==1) {
    #   modelMetrics <- rbind(modelMetrics, list(0, 0))
    # }
    
    # plot2 <- ggplot(modelMetrics, aes(x=fpr, y=tpr, group=1)) + 
    #   labs(title="AUC", x="", y="") + 
    #   annotate("text", x=0.5, y= 0.5 ,label=as.character(round(modelAUC,4)),size = 15) +
    #   theme(axis.line=element_blank(),axis.text.x=element_blank(),axis.text.y=element_blank(),axis.ticks=element_blank(),axis.title.x=element_blank(),
    #         axis.title.y=element_blank(),legend.position="none",panel.background=element_blank(),panel.border=element_blank(),
    #         panel.grid.major=element_blank(),panel.grid.minor=element_blank(),plot.background=element_blank())
    
    
    # pokerTrainH2O_MD_NN5050_CM <- h2o.confusionMatrix(pokerTrainH2O_MD_NN5050)
    # kable(pokerTrainH2O_MD_NN5050_CM, format = "markdown")
    #?h2o.removeAll()
    
    #scoring a model:
    #scores <- h2o.predict(model_random_forest, test_data)
    
    
    # load the model
    #saved_model <- h2o.loadModel(model_path)
    
    #free memory
    #rm(trainData)
    #rm(trainDataH2O)
    
    #h2o.shutdown(prompt = FALSE)
    
    
    #free memory

  } # end of "if (file.exists(RDSModelFile) != TRUE)"

}
