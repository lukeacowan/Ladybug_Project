# **Ladybug_Project**

## Introduction
- We will provide a data dictionary, describe the cleaning process, and provide analysis for the two ladybug data sets.
---
## Data Dictionary :orange_book:
The columns that we used include:
- catalogNumber/SCAN.CODE: A code consisting of the institutionCode, collectionCode, and a unique number that is assigned to each ladybug recorded (changed to "scanCode")
- plot: the type of area in which a ladybug was located (changed to "Location")
- stateProvince: the name of a state where a sample was recorded (changed to "State")
- scientificName/Species: the scientific name of a ladybug species 
- recordedBy: the name of the person who recorded the ladybug (changed to "Collectors")
- year: the year in which the sample was recorded
- specificEpithet: the specific species within a genus that makes up the second portion of the scientific name of the ladybug

The columns we created include: 
- ladyBugsFound: the number of ladybugs found
- decade: the decade in which the sample was recorded
---
## Cleaning Process :broom:
1. Changing Indescript plot values to their specific meaning <br>
```
location_found$Location <- gsub("LP-AG-1", "Agriculture", location_found$Location) 
location_found$Location <- gsub("LP-GM-1", "Mowed Grass", location_found$Location) 
location_found$Location <- gsub("LP-GU-1", "Unmowed Grass", location_found$Location) 
location_found$Location <- gsub("LP-IC-1", "Industrial", location_found$Location) 
location_found$Location <- gsub("LP-PR-1", "Prairie", location_found$Location) 
location_found$Location <- gsub("LP-GA-1", "Garden", location_found$Location) 
location_found$Location <- gsub("LP-GF-1", "Forested", location_found$Location)
```




:mag:
 
<img src="Project-Insect-Carnivore-main/State Visualization.png">

<img src="Project-Insect-Carnivore-main/Location Visualization.png">

<img src="Project-Insect-Carnivore-main/Augie Collector Visualization.png">

<img src="Project-Insect-Carnivore-main/Ladybugs by Decade Visualization.png">

<img src="Project-Insect-Carnivore-main/ttest.png">

:lady_beetle:



