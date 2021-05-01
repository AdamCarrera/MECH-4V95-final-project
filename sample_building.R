# Sample buildings - build data frame of usage values based on random sample

sample_building <- function(samples, building_list) {
  
  values <- list()
  
  for (sample in samples) {
    
    consumption <- as.data.frame(building_list[[sample]]$value)
    
    values <- append(values, consumption)
    
  }
  
  return(values)
  
}
