# Preprocessing, generate a list of all buildings containing the name and value

path = paste0(getwd(), "/data/") # set your working dir to this repo first

#data = read.csv(paste0(path, "6.csv"))

# each building is a data frame, with a name and time series
# append each building to the building list

files <- list.files(path=path, pattern="*.csv", full.names=FALSE, recursive=FALSE)

building_list <- list()

for (file in files) {
  name = file
  data = read.csv(file = paste0(path, file))
  data = ts(data$value, start = 0)

  building = data.frame(name = name, data = data)
  
  building_list <- append(building_list, building)
  
}
