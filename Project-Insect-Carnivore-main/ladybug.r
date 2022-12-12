#DATA 331 Ladybug Code
library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list = ls())


setwd("~/Data 331/Final project/Ladybug_Project/Project-Insect-Carnivore-main")

#reading both ladybug data sets in
df_ladybug <- read_excel("data/Ladybug Data.xlsx", .name_repair = "universal")
df_scan_ladybug <- read.csv("data/Scan Ladybug Data.csv")

#renaming column names for clarity and joining the data sets
joined_df <- df_scan_ladybug %>%
  dplyr::rename("SCAN.CODE" = "catalogNumber") %>%
  left_join(df_ladybug, by = c("SCAN.CODE")) %>% 
  dplyr::rename("scanCode" = "SCAN.CODE") %>%
  dplyr::rename(Location = plot)

#dplyr::selecting only the data for the ladybugs collected by the Augustana students
location_found <- joined_df %>%
  dplyr::filter(Species != 'UNKNOWN') %>%
  dplyr::select(Species, Location)

#switching the plot names to show the type of area the ladybugs were collected in  
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

#cleaning species names to eliminate inconsistent spellings
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
location_found$Species <- gsub("Coccinella Septempunctata", "Coccinella septempunctata", location_found$Species)
location_found$Species <- gsub("coccinella septempunctata", "Coccinella septempunctata", location_found$Species)
location_found$Species <- gsub("Coccinella semtempuncata", "Coccinella septempunctata", location_found$Species)

#finding total of species collected for each location
location_amount <- location_found %>%
  count(Species, Location) %>%
  dplyr::rename(ladybugsFound = n)

#location visualization
ggplot(data = location_amount, aes(x = Species, y = ladybugsFound, fill = Location)) +
  geom_col(position = position_stack()) +
  coord_flip() + scale_y_continuous(name="Ladybugs Found") +
  scale_x_discrete(name="Species") +
  ggtitle("Number of Ladybugs Found in Each Location by Species") 

#finding total of species collected in each state
ladybug_states <- df_scan_ladybug %>%
  dplyr::select(scientificName, stateProvince) %>%
  dplyr::filter(scientificName != '') %>%
  count(scientificName, stateProvince) %>%
  dplyr::rename(ladybugsFound = n) %>%
  dplyr::rename(State = stateProvince)

#fixing incorrect notation of ladybug and state names
ladybug_states$scientificName <- gsub("harmonia axyridis", "Harmonia axyridis", ladybug_states$scientificName)
ladybug_states$State <- gsub("IL", "Illinois", ladybug_states$State)
ladybug_states$State <- gsub("IA", "Iowa", ladybug_states$State)

#filtering for ladybugs collected in Illinois and Iowa only
corrected_states <- ladybug_states %>%
  dplyr::filter((State == "Illinois") | (State == "Iowa"))

#state visualization
ggplot(data = corrected_states, aes(x = scientificName, y = ladybugsFound, fill = State)) +
  geom_col(position = position_stack()) +
  coord_flip() + scale_y_continuous(name="Ladybugs Found") +
  scale_x_discrete(name="Species") +
  ggtitle("Number of Ladybugs Found in IL and IA by Species") 

#copy of joined dataframe to be used for consistent formatting of collector names
collectors <- joined_df

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

#identifying and summing ladybugs recorded by each Augie student individually
augie_collectors <- collectors %>%
  dplyr::filter((recordedBy == "Veronica Cervantes") | (recordedBy == "Olivia Ruffatto") | (recordedBy == "Jack Hughes") | (recordedBy == "Marissa Gorsegner")) %>%
  dplyr::select(scientificName, recordedBy) %>%
  dplyr::filter(scientificName != '') %>%
  count(scientificName, recordedBy) %>%
  dplyr::rename(ladybugsFound = n) %>%
  dplyr::rename(Collectors = recordedBy)

#fixing incorrect notation of ladybug name for consistency 
augie_collectors$scientificName <- gsub("harmonia axyridis", "Harmonia axyridis", augie_collectors$scientificName)  

#Augie collector visualization
ggplot(data = augie_collectors, aes(x = scientificName, y = ladybugsFound, fill = Collectors)) +
  geom_col(position = position_dodge()) +
  coord_flip() + scale_y_continuous(name="Ladybugs Found") +
  scale_x_discrete(name="Species") +
  ggtitle("Number of Ladybugs Found by Collectors for Each Species")
  
#filtering for six of the most commonly found species of ladybugs since 1960s
ladybug_decade <- df_scan_ladybug %>%
  dplyr::select(scientificName, year) %>%
  dplyr::filter((scientificName == "Cycloneda sanguinea") | (scientificName == "Chilocorus stigma") | (scientificName == "Coccinella septempunctata") | (scientificName == "Coleomegilla maculata") | (scientificName == "Hippodamia convergens") | (scientificName == "Harmonia axyridis")) 

#adding a decade column that corresponds with year to enable grouping by decade
ladybug_decade$decade <- substr(ladybug_decade$year, 1, 3)
ladybug_decade$decade <- paste0(ladybug_decade$decade, "0s")

#summing the ladybugs found in each decade and their proportion relative to the total number of ladybugs found 
ladybug_by_decade <- ladybug_decade %>%
  dplyr::group_by(decade, scientificName) %>%
  dplyr::filter(decade != "NA0s") %>%
  dplyr::summarise(ladybugsFound = n()) %>%
  mutate(percentage = ladybugsFound / sum(ladybugsFound))

#creating a data frame to prevent discontinuity in the line graph below due to decades where certain ladybugs were not collected
filler_data = data.frame(decade=c("1960s","1960s", "1960s", "1970s", "1970s", "1980s", "1990s", "2000s", "2000s", "2000s", "2010s", "2010s", "2010s", "2010s", "2020s"), scientificName=c("Chilocorus stigma", "Coccinella septempunctata", "Harmonia axyridis", "Coccinella septempunctata", "Harmonia axyridis", "Harmonia axyridis", "Harmonia axyridis", "Chilocorus stigma", "Hippodamia convergens", "Harmonia axyridis", "Cycloneda sanguinea", "Chilocorus stigma", "Hippodamia convergens", "Harmonia axyridis", "Cycloneda sanguinea"), ladybugsFound=c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0), percentage=c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
ladybug_by_decade <- rbind(ladybug_by_decade, filler_data)

#ladybug proportion by decade visualization
ggplot(ladybug_by_decade, aes(x = decade, y = percentage, group = scientificName))+
  geom_line(aes(colour=scientificName), lwd=1.0) + 
  xlab("Decade") + 
  ylab("Proportion of Total Ladybugs Found") + 
  ggtitle("Proportion of Ladybugs Found by Decade") 

#finding count of each epithet
ladybug_epithet <- joined_df %>%
  dplyr::filter(Species != 'UNKNOWN') %>%
  dplyr::select(specificEpithet) %>%
  dplyr::filter(specificEpithet != '') %>%
  count(specificEpithet) %>%
  dplyr::rename(ladybugsFound = n) 

#performing one-sample t-test for the mean number of ladybugs per epithet
t.test(ladybug_epithet$ladybugsFound, mu=40)











