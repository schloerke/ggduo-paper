

library(ggplot2)
library(GGally)



source_all <- function() {

  wd <- getwd()

  files <- dir()

  if ("scripts" %in% files) {
    on.exit({
      setwd(wd)
    })
    setwd("scripts")
    source_all()
    return()
  }

  files <- files[files != "_run_all.R"]

  lapply(files, function(file) {
    message("Sourcing file: ", file)
    source(file)
  })
}

source_all()
