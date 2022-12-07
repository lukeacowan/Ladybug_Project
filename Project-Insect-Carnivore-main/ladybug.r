library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list = ls())


setwd("~/Data 331/Final project/final_project/Project-Insect-Carnivore-main")

#reading the ladybug data in
ladybug_condensed <- read_excel("data/Ladybug Data.xlsx", .name_repair = "universal")
ladybugs <- read.csv("data/Scan Ladybug Data.csv")

found_ladybug <- ladybug_condensed %>%
  dplyr::filter(Species != 'UNKNOWN') %>% 
  dplyr::rename(Location = plot)

location_found <- found_ladybug %>%
  select(Species, Location)

location_found$Location <- gsub("LP-AG-1", "Agriculture", location_found$Location)  
location_found$Location <- gsub("LP-AG-2", "Agriculture", location_found$Location) 
location_found$Location <- gsub("LP-AG-3", "Agriculture", location_found$Location) 
location_found$Location <- gsub("LP-AG-4", "Agriculture", location_found$Location)  
location_found$Location <- gsub("LP-AG-5", "Agriculture", location_found$Location)  
location_found$Location <- gsub("LP-GM-1", "Mowed Grass", location_found$Location)  
location_found$Location <- gsub("LP-GM-2", "Mowed Grass", location_found$Location) 
location_found$Location <- gsub("LP-GM-3", "Mowed Grass", location_found$Location)  
location_found$Location <- gsub("LP-GM-4", "Mowed Grass", location_found$Location)  
location_found$Location <- gsub("LP-GM-5", "Mowed Grass", location_found$Location)
location_found$Location <- gsub("LP-GU-1", "Unmowed Grass", location_found$Location)
location_found$Location <- gsub("LP-GU-2", "Unmowed Grass", location_found$Location)
location_found$Location <- gsub("LP-GU-3", "Unmowed Grass", location_found$Location)
location_found$Location <- gsub("LP-GU-4", "Unmowed Grass", location_found$Location)
location_found$Location <- gsub("LP-GU-5", "Unmowed Grass", location_found$Location)
location_found$Location <- gsub("LP-IC-1", "Industrial", location_found$Location)
location_found$Location <- gsub("LP-IC-2", "Industrial", location_found$Location)
location_found$Location <- gsub("LP-IC-3", "Industrial", location_found$Location)
location_found$Location <- gsub("LP-IC-4", "Industrial", location_found$Location)
location_found$Location <- gsub("LP-IC-5", "Industrial", location_found$Location)
location_found$Location <- gsub("LP-PR-1", "Prairie", location_found$Location)
location_found$Location <- gsub("LP-PR-2", "Prairie", location_found$Location)
location_found$Location <- gsub("LP-PR-3", "Prairie", location_found$Location)
location_found$Location <- gsub("LP-PR-4", "Prairie", location_found$Location)
location_found$Location <- gsub("LP-PR-5", "Prairie", location_found$Location)
location_found$Location <- gsub("Lp-PR-5", "Prairie", location_found$Location)
location_found$Location <- gsub("LP-GA-1", "Garden", location_found$Location)
location_found$Location <- gsub("LP-GA-2", "Garden", location_found$Location)
location_found$Location <- gsub("LP-GA-3", "Garden", location_found$Location)
location_found$Location <- gsub("LP-GA-4", "Garden", location_found$Location)
location_found$Location <- gsub("LP-GA-5", "Garden", location_found$Location)
location_found$Location <- gsub("LP-GF-1", "Forested", location_found$Location)
location_found$Location <- gsub("LP-GF-2", "Forested", location_found$Location)
location_found$Location <- gsub("LP-GF-3", "Forested", location_found$Location)
location_found$Location <- gsub("LP-GF-4", "Forested", location_found$Location)
location_found$Location <- gsub("LP-GF-5", "Forested", location_found$Location)

location_found$Species <- gsub("Propylea quatuordecimpuncata", "Propylea quatuordecimpunctata", location_found$Species)
location_found$Species <- gsub("hippodamia parenthesis", "Hippodamia parenthesis", location_found$Species)
location_found$Species <- gsub("hippodamia convergens", "Hippodamia convergens", location_found$Species)
location_found$Species <- gsub("Hippodamia convergence", "Hippodamia convergens", location_found$Species)
location_found$Species <- gsub("Hippodamia covergence", "Hippodamia convergens", location_found$Species)
location_found$Species <- gsub("Harmonia axyrisis", "Harmonia axyridis", location_found$Species)
location_found$Species <- gsub("harmonia axyrids", "Harmonia axyridis", location_found$Species)
location_found$Species <- gsub("harmonia axyridis", "Harmonia axyridis", location_found$Species)
location_found$Species <- gsub("Harminia axyridis", "Harmonia axyridis", location_found$Species)
location_found$Species <- gsub("Cycloneda Munda", "Cycloneda munda", location_found$Species)
location_found$Species <- gsub("cycloneda munda", "Cycloneda munda", location_found$Species)
location_found$Species <- gsub("coleomegilla maculata", "Coleomegilla maculata", location_found$Species)
location_found$Species <- gsub("Colemegilla maculata", "Coleomegilla maculata", location_found$Species)
location_found$Species <- gsub("Coccinella Septempunctata", "Coccinella septemunctata", location_found$Species)
location_found$Species <- gsub("coccinella septempunctata", "Coccinella septemunctata", location_found$Species)
location_found$Species <- gsub("Coccinella semtempuncata", "Coccinella septemunctata", location_found$Species)
location_found$Species <- gsub("Coccinella septempunctata", "Coccinella septemunctata", location_found$Species)








ggplot(data = location_found, aes(x = Species, y = Location)) +
  geom_col(position = position_dodge()) +
  coord_flip() + scale_y_continuous(name="Number Found") +
  #scale_x_discrete(name="Ladybug Found") 








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

# documentation: struggled to get rid of rows with empty records for ladybug name
#              add comment
collector_comparison <- Augie_collectors %>%
  select(scientificName, recordedBy) %>%
  dplyr::filter(scientificName != '') %>%
  count(scientificName, recordedBy) %>%
  dplyr::rename(ladybugsFound = n) %>%
  dplyr::rename(Collectors = recordedBy)


#visualization for collector_comparison dataframe
ggplot(data = collector_comparison, aes(x = scientificName, y = ladybugsFound, fill = Collectors)) +
  geom_col(position = position_dodge()) +
  coord_flip() + scale_y_continuous(name="Number Found") +
  scale_x_discrete(name="Ladybug Found") 

state_comparison <- collectors %>%
  select(scientificName, stateProvince) %>%
  dplyr::filter(scientificName != '') %>%
  count(scientificName, stateProvince) %>%
  dplyr::rename(ladybugsFound = n) %>%
  dplyr::rename(State = stateProvince)

#visualization for state_comparison dataframe
ggplot(data = state_comparison, aes(x = scientificName, y = ladybugsFound, fill = State)) +
  geom_col(position = position_dodge()) +
  coord_flip() + scale_y_continuous(name="Number Found") +
  scale_x_discrete(name="Ladybug Found") 

  
  
  
  





  

