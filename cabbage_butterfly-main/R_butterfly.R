library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
library(ggplot2)
library(leaflet)
rm(list = ls())

setwd("C:/Users/Eirik/OneDrive/College/Senior/Data 331/Github/final_project/cabbage_butterfly-main/data")

complete_df <- read_excel('CompletePierisData_2022-03-09.xlsx', .name_repair = 'universal')
cleaned_df <- read_excel('Cleaned Data LWA .xlsx', .name_repair = 'universal')

#select necessary columns from complete_df to add to cleaned_df
new_cols <- complete_df %>%
  select(coreid, dwc.decimalLatitude, dwc.decimalLongitude, LAnteriorSpotM3,
         RAnteriorSpotM3, dwc.country, dwc.year) %>%
  dplyr::rename(core.ID = coreid)

#join the columns to cleaned_df
cleaned_df <- cleaned_df %>%
  dplyr::left_join(new_cols, by= c('core.ID')) %>%
  na.omit(cleaned_df)

cleaned_df$LAnteriorSpotM3 <- as.numeric(cleaned_df$LAnteriorSpotM3)

#change column names
colnames(cleaned_df)[which(names(cleaned_df) == "dwc.decimalLongitude")] <- "longitude"
colnames(cleaned_df)[which(names(cleaned_df) == "dwc.decimalLatitude")] <- "latitude"
colnames(cleaned_df)[which(names(cleaned_df) == 'dwc.country')] <- "country"
colnames(cleaned_df)[which(names(cleaned_df) == 'dwc.year')] <- "year"
                           
#two sample t-test on the left wing length vs right wing length
t.test(cleaned_df$LW.length, cleaned_df$RW.length)  
# p-value of .9447 shows that there is no significant difference between right and left wing length

#make box plots to show distribution of wing size - t-test shows no significant difference between
# wings so only plot left wing
wing_length <- ggplot(cleaned_df, aes(sex, LW.length))
wing_length + geom_boxplot() + ylab('wing length') + labs(title = 'Wing Size by Sex')
#female butterflies have larger wings than male butterflies

#overall statistics for wing length and width
avg_wing_length <- mean(c(cleaned_df$LW.length, cleaned_df$RW.length))
avg_wing_width <- mean(c(cleaned_df$LW.width, cleaned_df$RW.width))
median_length <- median(c(cleaned_df$LW.length, cleaned_df$RW.length))
median_width <- median(c(cleaned_df$LW.width, cleaned_df$RW.width))
min_length <- min(c(cleaned_df$LW.length, cleaned_df$RW.length))
min_width <- min(c(cleaned_df$LW.width, cleaned_df$RW.width))
max_length <- max(c(cleaned_df$LW.length, cleaned_df$RW.length))
max_width <- max(c(cleaned_df$LW.width, cleaned_df$RW.width))

#pivot table to compare male and female
comparison <- cleaned_df %>%
  select(sex, LW.length, LW.apex.A, LAnteriorSpotM3) %>%
  group_by(sex) %>%
  summarise(mean_wing_length = mean(LW.length),
            mean_apex = mean(LW.apex.A),
            mean_spot = mean(LAnteriorSpotM3),
            max_wing_length = max(LW.length),
            max_apex = max(LW.apex.A),
            max_spot = max(LAnteriorSpotM3))

#comparison to show how location affects size
location <- cleaned_df %>%
  select(country, LW.length, LW.apex.A, LAnteriorSpotM3) %>%
  group_by(country) %>%
  summarise(mean_wing_length = mean(LW.length),
            mean_apex = mean(LW.apex.A),
            mean_spot = mean(LAnteriorSpotM3),
            max_wing_length = max(LW.length),
            max_apex = max(LW.apex.A),
            max_spot = max(LAnteriorSpotM3))

#box plot to show how location affects size
size_country <- ggplot(cleaned_df, aes(country, LW.length))
size_country + geom_boxplot() + ylab('wing length') + labs(title = 'Wing Size by Country')

#average size by year
avg_size_year <- cleaned_df %>%
  group_by(year) %>%
  summarise(avg_wing_size = mean(LW.length),
            avg_spot = mean(LAnteriorSpotM3),
            avg_apex = mean(LW.apex.A))

barplot(avg_size_year$avg_wing_size,
        names.arg = avg_size_year$year,
        ylim = c(0,30),
        main = "Wing Size by Year",
        xlab = 'year', ylab = 'wing size')

#average size by decade
avg_size_decade <- cleaned_df %>%
  mutate(decade = as.numeric(year) - as.numeric(year) %% 10) %>%
  group_by(decade) %>%
  summarise(avg_wing_size = mean(LW.length),
            avg_spot = mean(LAnteriorSpotM3),
            avg_apex = mean(LW.apex.A))

ggplot(avg_size_decade, aes(decade,avg_wing_size)) +
  geom_bar(stat="identity", position = "dodge") +
  labs(title="Average wing size by decade") +
  ylab('wing length')

#geospatial map of findings
m <- leaflet() %>%
  addTiles() %>%
  addCircleMarkers(
    lng=cleaned_df$longitude, lat=cleaned_df$latitude,
    color = 'green', radius = 5)
m  # Print the map
