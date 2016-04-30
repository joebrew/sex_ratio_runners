################################################################
# This script reads in data for simming, marathon, and tour de france 
# and makes one data frame alphabetized by name wtih sport, son, daughter, 
# and column for checked or not 

home <- '/home/benbrew/Documents'
project_folder <- paste0(home, '/sex_ratio_runners')
data_folder <- paste0(project_folder, '/data')

run <- read.csv(paste0(data_folder, '/olympic_marathon_2000_2012.csv'))
swim <- read.csv(paste0(data_folder, '/olympic_1500_2000_2012.csv'))
bike <- read.csv(paste0(data_folder, '/tour_de_france_2000_2012.csv'))

# renmae rank column as result
names(bike)[3] <- "result"

# aggregate data 
data <- rbind(bike, run, swim)

# remove duplicates 
data <- data[!duplicated(data$name),]

# remove unnecssary columns and add searched
data$country <- NULL 
data$result <- NULL
data$source <- NULL
data$comment <- NULL
data$result_source <- NULL
data$sport <- ifelse(grepl("marathon", data$event), "maration", 
                     ifelse(grepl("tour", data$event), "tour_de_france", "swim_1500"))
data$event <- NULL
data$checked <- FALSE

row.names(data) <- NULL 

write.csv(data, paste0(data_folder, "/data.csv"), row.names=FALSE)
