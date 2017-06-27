#' 
#' \code{BuildPresentation} creates the final presentation
#' 
#' @examples 
#' BuildPresentation()
#' 
#BuildPresentation <- function() {
  
  docDir <- getDocDir()
  docInputDir <- getDocInputDir()
  
  
  pptx.file <- 
    paste(docDir,
          "FinalPresentation.pptx",
          sep="/")
  
  doc <- 
    pptx(title="Prediction of Animal Strike on US Commercial Flights")
  
  doc <-
    addSlide(doc,
             slide.layout="Title Slide")
  doc <-
    addTitle(doc,
             "Prediction of Animal Strike on US Commercial Flights")
  doc <-
    addSubtitle(doc,
                "Gábor Horváth")
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Business objectives" )
  text = c("Create a statistical analysis to identify those reasons (based on the data available), which are determining the the risk of an animal strike for an airport.",
           "Create a prediction model, which can be used to predict the risk of an animal strike for a given flight.")
  doc <-
    addParagraph(doc,
                 value = text )

  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Data sources" )
  text = c("Federal Aviation Administration - Wildlife Strike Database",
           "United States Department of Transportation - Bureau of Transportation Statistics - Flight performance",
           "Federal Aviation Administration - Airport Data & Contact Information")
  doc <-
    addParagraph(doc,
                 value = text )
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Tools used" )
  text = c("R",
           "R Studio",
           "knitr, MiKTeX",
           "ggplot2",
           "H2O",
           "CRIPS-DM process model",
           "buckets, github")
  doc <-
    addParagraph(doc,
                 value = text )
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Strike distribution" )
  image <- paste(docInputDir,
                 "USA_Airports.png",
                 sep="/")
  doc <- addImage(doc, image)
  
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Model 01 - details" )
  text = c("log-log linear regression model",
           "categorical and continous predictor variables from airport point of view",
           "outcome variable: number of animal strike per airport",
           "location and traffic of the airport influence the outcome")
  doc <-
    addParagraph(doc,
                 value = text )

  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Model 02 - details" )
  text = c("H2O platform - Java",
           "categorical and continous predictor variables from flight point of view",
           "outcome variable: flight got animal strike or not",
           "most influental predictors were the airports (origin, destination), the arrival and departure time blocks and the month")
  doc <-
    addParagraph(doc,
                 value = text )
  
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Receiver Operating Characteristic (ROC) curve" )
  image <- paste(docInputDir,
                 "GBM_Model_ROC_valid.jpg",
                 sep="/")
  doc <- addImage(doc,
                  image,
                  width = 5,
                  height = 5,
                  par.properties = parProperties(align = "center"))
  
  
  doc <- 
    addSlide(doc,
             slide.layout="Title and Content")
  doc <-
    addTitle(doc,"Confusion matrix" )
  image <- paste(docInputDir,
                 "GBM_Model_scoring.jpg",
                 sep="/")
  doc <- addImage(doc,
                  image,
                  width = 7,
                  height = 5,
                  par.properties = parProperties(text.align = "center"))
  
  doc <-
    addSlide(doc,
             slide.layout="Title Slide")
  doc <-
    addTitle(doc,
             "Thank you")

  writeDoc(doc,
           file = pptx.file)

#}
