#Lauri Leinonen
#11.11.2022
#R script file for assignment 2 / IODS2022, data from Kimmo Vehkalahti


# PArt 1 of Data wrangling: creating this R script file into the appropriate folder

# PART 2 of Data wrangling

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
str(lrn14)
#dimensions 183 rows and 60 columns to begin with
#structure-wise pretty large; age, attitude, points and gender as the final columns, all the other 56 columns just integers

#just comparing the str() to glimpse() found in tidyverse
#library(tidyverse)
#glimpse(lrn14)


# PART 3 of Data wrangling

library(dplyr)

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns 
deep_columns <- select(lrn14, one_of(deep_questions))
surface_columns <- select(lrn14, one_of(surface_questions))
strategic_columns <- select(lrn14, one_of(strategic_questions))

# and create averages -> columns 
lrn14$deep <- rowMeans(deep_columns)
lrn14$surf <- rowMeans(surface_columns)
lrn14$stra <- rowMeans(strategic_columns)
# change attitude score to correlate - was this necessary?
lrn14$attitude <- lrn14$Attitude / 10

# new subset with just the seven needed variables
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(lrn14, one_of(keep_columns))


# change colnames(learning2014) accordingly
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

#remove rows with zero points
learning2014 <- filter(learning2014, points > 0)

# now 166 rows and 7 variables

# Part 4 of Data wrangling
getwd() #working directory check
setwd("data")

#writing into csv file
library(tidyverse)
?write_csv()
write_csv(learning2014, "learning2014.csv")


#reading the csv and comparing it to the original
test <- read_csv("learning2014.csv")
dim(test)
str(test)
head(test)

dim(learning2014)
str(learning2014)
head(learning2014)

View(test)

# everything ok


