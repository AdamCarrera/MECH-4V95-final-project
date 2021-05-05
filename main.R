# Main - Preform ARIMA forecast on a single meter

library(lubridate)
library(ggplot2)
library(forecast)
library(tseries)

# Set working directory to this repo
setwd("~/GitHub/MECH-4V95-final-project")

# set a path to the csv directory
path_to_files = paste0(getwd(), "/data/")


# load functions for preprocessing and plotting
source(paste0(getwd(), '/preprocessing.R'))
source(paste0(getwd(), '/consumption_plot.R'))


# obtain list of all buildings
data_set <- preprocess(path_to_files)


# plot time series, observe trends

consumption_plot(data_set = data_set[[1]][1:286,], building_number = 1)


# convert consumption data into time series for forecasting
y <- data_set[[1]][1:286,3]
y <- ts(y, start = 0, frequency = 13)
autoplot(y) + labs(x = 'Time', y = 'Load', title = 'Building One Time series, ~1 day') # plot time series, observe that it is non-stationary

# Determine 'd' value via adf test
# null hypothesis - non-stationary
# reject if p > 1%, increment 'd'
adf.test(y, k = 13) # non-stationary, (p > 0.01)

y_2 <- diff(y, differences = 1) # increase differences from 0 to 1

adf.test(y_2, k = 13) # stationary! :) (p < 0.01)

autoplot(y_2) + labs(x = 'Time', y = 'Load', title = 'Building One Time series, ~1 day') # visually confirm series is stationary, let d = 1


# determine order of AR and MA model, count spikes above blue line
Pacf(y_2) # p = 7
acf(y_2) # q = 8


# build ARIMA model using parameters found previously
tsMod <- Arima(y = y, order = c(7, 1, 8))

# forecast one hour ahead and plot
y_forecast <- forecast(tsMod, h=13)
autoplot(y_forecast) + labs(x = 'Time', y = 'Load')


# forecast was done in the past, so we have access to the real data
# evaluate prediction using RSME and MAE 
y_predict <- y_forecast$mean
y_real <- data_set[[1]][286:298,3]

error <- y_predict - y_real # Take difference between predicted data and actual data

# Take RMSE and MAE errors
predictionRMSE <- sqrt(mean(error^2))
predictionMAE <- mean(abs(error))

