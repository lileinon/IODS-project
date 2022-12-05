# Lauri Leinonen
# IODS 7 2022

# Assignment 4
# Data Wrangling
# 28.11.2022


library(tidyverse)
library(dplyr)

########### 2 ############# load in the data

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

########### 3 ############# explore datasets

dim(hd) # 195 obs. of 8 var.
dim(gii) # 195 obs. of 10 var.

glimpse(hd)
glimpse(gii)

str(hd)
str(gii)

# ok, interesting, Human development index and Gender inequality index. Country -variabe would be the means to combine the two tables.


########### 4 ############# meta files and renaming

# ?rename

hd <- rename(hd, 
             "HDI.rank" = "HDI Rank",
             "HDI" = "Human Development Index (HDI)", 
             "Life.Exp" = "Life Expectancy at Birth",
             "Edu.Exp" = "Expected Years of Education",
             "Edu.Mean" = "Mean Years of Education",
             "GNI" = "Gross National Income (GNI) per Capita",
             "GNI.HDI.Rank" = "GNI per Capita Rank Minus HDI Rank" 
             )

gii <- rename(gii,
             "GII.Rank" = "GII Rank",
             "GII" = "Gender Inequality Index (GII)",
             "Mat.Mor" = "Maternal Mortality Ratio",
             "Ado.Birth" = "Adolescent Birth Rate",
             "Parli.F" = "Percent Representation in Parliament",
             "Edu2.F" = "Population with Secondary Education (Female)",
             "Edu2.M" = "Population with Secondary Education (Male)",
             "Lab.F" = "Labour Force Participation Rate (Female)",
             "Lab.M" = "Labour Force Participation Rate (Male)",
             )


########### 5 ############# mutate gii + 2 new vars, (edu2FM and labFM)

gii <- mutate(gii,
              Edu2.FM = Edu2.F / Edu2.M,
              Lab.FM = Lab.F / Lab.M
              )


########### 6 ############# create human and save it as csv -> Turned obsolete, will redo later

human <- inner_join(hd, gii, by = "Country")

#getwd()
#setwd("data")

#write_csv(human, "human.csv") 



# checked, is fine
# All done.


# NEW / CONTINUING DATA WRANGLING

# Data already loaded, 195 observations of 19 variables, human development index and gender inequality index -factors. 

########### 5.1 ############# GNI to numeric

str(human)

# as can be seen, GNI already is numeric, but if it would not be,  removing commas and changing the type to numeric would work with:
# human$gni <- gsub(",", "", human$gni) %>% as.numeric


########### 5.2 ############# Keep only 9 variables as instructed:

# columns to keep
keep <- c("Edu2.FM", "Lab.FM", "Country", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

########### 5.3 ############# Remove rows with NA:

human <- filter(human, complete.cases(human))

########### 5.4 ############# Remove regions

last <- nrow(human) - 7
human <- human[1:last, ]

########### 5.5 ############# Rename rows as countries, remove country-column


rownames(human) <- human$Country

human_ <- select(human, -Country)


### write to file ###


getwd()
setwd("data")

write.csv(human_, "human.csv", row.names = TRUE) # had to use write.csv because writing row names wasn't apparently possible in write_csv


###### DONE #########
