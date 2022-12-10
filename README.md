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
1. Changed Indescript plot values to their specific meaning <br>
```
location_found$Location <- gsub("LP-AG-1", "Agriculture", location_found$Location) 
location_found$Location <- gsub("LP-GM-1", "Mowed Grass", location_found$Location) 
location_found$Location <- gsub("LP-GU-1", "Unmowed Grass", location_found$Location) 
location_found$Location <- gsub("LP-IC-1", "Industrial", location_found$Location) 
location_found$Location <- gsub("LP-PR-1", "Prairie", location_found$Location) 
location_found$Location <- gsub("LP-GA-1", "Garden", location_found$Location) 
location_found$Location <- gsub("LP-GF-1", "Forested", location_found$Location)
```
- This was done for plots 1-5 of each type.

2. Cleaned the species column <br>
- Spelling of species names was inconsistent
- Changed to abide by the actual scientific name
```
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
```

3. Corrected grammar inconsistency for one of the species in the scientificName column <br>
- Incorrect capitilization created duplicate values
```
ladybug_states$scientificName <- gsub("harmonia axyridis", "Harmonia axyridis", ladybug_states$scientificName)  
augie_collectors$scientificName <- gsub("harmonia axyridis", "Harmonia axyridis", augie_collectors$scientificName) 
```
- Code shown above was used in three separate data frames

4. Cleaned the recordedBy column <br>
- Format and capitilization of collectors' first and last names was inconsistent
- Changed them to include their capitalized first and last names
```
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
```

5. Renamed column names when needed or desired
- Frequently used dplyr::rename() function

6. Omitted missing/NA values
```
dplyr::filter(Species != 'UNKNOWN')
dplyr::filter(scientificName != '')
dplyr::filter(decade != "NA0s")
```
- Code shown above was used in three separate data frames

:mag:
 
<img src="Project-Insect-Carnivore-main/State Visualization.png">

<img src="Project-Insect-Carnivore-main/Location Visualization.png">

<img src="Project-Insect-Carnivore-main/Augie Collector Visualization.png">

<img src="Project-Insect-Carnivore-main/Ladybugs by Decade Visualization.png">

<img src="Project-Insect-Carnivore-main/ttest.png">

:lady_beetle:



