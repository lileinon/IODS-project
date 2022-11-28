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
             "hdi_rank" = "HDI Rank",
             "country" = "Country",
             "hdi" = "Human Development Index (HDI)", 
             "life_exp" = "Life Expectancy at Birth",
             "edu_exp" = "Expected Years of Education",
             "edu_mean" = "Mean Years of Education",
             "gni" = "Gross National Income (GNI) per Capita",
             "gni_hdi_rank" = "GNI per Capita Rank Minus HDI Rank" 
             )

gii <- rename(gii,
             "gii_rank" = "GII Rank",
             "country" = "Country",
             "gii" = "Gender Inequality Index (GII)",
             "mat_mor" = "Maternal Mortality Ratio",
             "ado_birth" = "Adolescent Birth Rate",
             "rep_parl" = "Percent Representation in Parliament",
             "edu2F" = "Population with Secondary Education (Female)",
             "edu2M" = "Population with Secondary Education (Male)",
             "labF" = "Labour Force Participation Rate (Female)",
             "labM" = "Labour Force Participation Rate (Male)",
             )


########### 5 ############# mutate gii + 2 new vars, (edu2FM and labFM)

gii <- mutate(gii,
              edu2FM = edu2F / edu2M,
              labFM = labF / labM
              )


########### 6 ############# create human and save it as csv

human <- inner_join(hd, gii, by = "country")
dim(human)


getwd()
setwd("data")

write_csv(human, "human.csv") 



# checked, is fine
# All done.

