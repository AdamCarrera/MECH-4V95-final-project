# Main - Run preprocessing on database and
#   plot 500 points of electricity usage for the first building

require(lubridate)
require(ggplot2)
# require(zoo)
# require(dtw)

library(forecast)
library(tseries)
setwd("~/GitHub/MECH-4V95-final-project")

path_to_files = paste0(getwd(), "/data/")

source(paste0(getwd(), '/preprocessing.R'))
source(paste0(getwd(), '/sample_building.R')) # Not used


data_set <- preprocess(path_to_files)

y <- data_set[[1]][1:286,3]

y <- ts(y, start = 0, frequency = 13)

autoplot(y)

adf.test(y, k = 13)

y_2 <- diff(y, differences = 1)

adf.test(y_2, k = 13)

autoplot(y_2) # d = 1

Pacf(y_2) # p = 7
acf(y_2) # q = 8

tsMod <- Arima(y = y, order = c(7, 1, 8))

autoplot(forecast(tsMod, h=13)) # 1 hour ahead forecast
