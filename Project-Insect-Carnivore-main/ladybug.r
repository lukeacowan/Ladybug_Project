library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list = ls())


setwd("~/Data 331/Final project/Project-Insect-Carnivore-main")

#reading the ladybug data in
ladybugs <- read.csv("data/Scan Ladybug Data.csv")

#copy of initial dataframe to be used for consistent formatting of state names
ladybugs_states <- ladybugs

#formatting states for consistency
ladybugs_states$stateProvince <- gsub("IL", "Illinois", ladybugs_states$stateProvince)
ladybugs_states$stateProvince <- gsub("IA", "Iowa", ladybugs_states$stateProvince)

#filtering for ladybugs collected in Iowa and Illinois only
state_collected <- ladybugs_states %>%
  dplyr::filter((stateProvince == "Illinois") | (stateProvince == "Iowa"))

#copy of dataframe above to be used for consistent formatting of collector names
collectors <- state_collected

#formatting collector names for consistency
collectors$recordedBy <- gsub("V. Cervantes", "Veronica Cervantes", collectors$recordedBy)
collectors$recordedBy <- gsub("Cervantes V.", "Veronica Cervantes", collectors$recordedBy)
collectors$recordedBy <- gsub("v. cervantes", "Veronica Cervantes", collectors$recordedBy)
collectors$recordedBy <- gsub("V. cervantes", "Veronica Cervantes", collectors$recordedBy)
collectors$recordedBy <- gsub("o. ruffatto", "Olivia Ruffatto", collectors$recordedBy)
collectors$recordedBy <- gsub("O. Ruffatto", "Olivia Ruffatto", collectors$recordedBy)
collectors$recordedBy <- gsub("Ruffatto O.", "Olivia Ruffatto", collectors$recordedBy)
collectors$recordedBy <- gsub("Hughes J.", "Jack Hughes", collectors$recordedBy)
collectors$recordedBy <- gsub("J. hughes", "Jack Hughes", collectors$recordedBy)
collectors$recordedBy <- gsub("j. hughes", "Jack Hughes", collectors$recordedBy)
collectors$recordedBy <- gsub("J. Hughes", "Jack Hughes", collectors$recordedBy)
collectors$recordedBy <- gsub("M. Gorsegner", "Marissa Gorsegner", collectors$recordedBy)
collectors$recordedBy <- gsub("m. Gorsegner", "Marissa Gorsegner", collectors$recordedBy)
collectors$recordedBy <- gsub("Gorsegner M.", "Marissa Gorsegner", collectors$recordedBy)
collectors$recordedBy <- gsub("m. gorsegner", "Marissa Gorsegner", collectors$recordedBy)

#filtering for ladybugs recorded in 2021 only
Augie_collectors <- collectors %>%
  dplyr::filter((recordedBy == "Veronica Cervantes") | (recordedBy == "Olivia Ruffatto") | (recordedBy == "Jack Hughes") | (recordedBy == "Marissa Gorsegner"))

state_comparison <- Augie_collectors %>%
  select(scientificName, recordedBy)





# everything below here is a work in progress
barplot(state_comparison$scientificName,
        main = 'Number of each ladybug found in IL vs IA',
        xlab = 'Scientific Name of Ladybugs',
        ylab = 'Total collected',
        col = c('blue', 'red'),
)
legend('topright',
       c('No', 'Yes'),
       fill = c('blue', 'red')
)

ggplot(data = state_comparison, aes(x = Ladybug, y = Total, fill = variable)) +
  geom_col(position = position_dodge()) 



  
  
  
  





  

