# Main - Run preprocessing on database and
#   plot 500 points of electricity usage for the first building

require(lubridate)
require(ggplot2)

setwd("~/GitHub/MECH-4V95-final-project")

path_to_files = paste0(getwd(), "/data/")

source(paste0(getwd(), '/preprocessing.R'))

data_set <- preprocess(path_to_files)

ggplot(aes(x = ymd_hms(dttm_utc), y = value), data=data_set[[1]][1:500,]) + geom_point()
# ymd_hms makes the x axis look better for date time
