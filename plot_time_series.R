# Plot Time Series of Electrical Consumption
# Input - Data Set, building number
# Return - none, plots figure to r studio window
# Example for data_set 'a' and building 3
#   consumption_plot(a, 3)
# NOTE: the data set makes use of the date time variable in the csv, so the input
#   must have both the consumption and date time values


library(ggplot2)
library(lubridate)

consumption_plot <- function(data_set, building_number) {
  
  p <- ggplot(data = data_set, aes(y = value, x = ymd_hms(dttm_utc))) + geom_line(size = 1)
  
  p + labs(x = "Date Time", y = "Consumption", 
           title = paste0("Time Series Electrical Consumpiton, Building ", building_number))
}