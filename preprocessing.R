# Preprocessing, generate a list of all buildings from csv files
# input: path to csv file location
# retrun, list of all csv files as data frames
#
# example on using output
#   all_files[[1]]$value <- first file, electricity consumtion

preprocess <- function(path) {

  files <- list.files(path=path, pattern="*.csv", full.names=FALSE, recursive=FALSE)
  
  setwd("~/GitHub/MECH-4V95-final-project/data")
  
  all_files <- lapply(files, read.csv)
  
  setwd("~/GitHub/MECH-4V95-final-project")
  
  return(all_files)
}


