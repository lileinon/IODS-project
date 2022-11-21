# 20.11.2022 
# L. Leinonen
# IODS2022 - Assignment 3: Data wrangling

########## 1 downloading data Done
########## 2 Creating this fole Done


########## 3 Reading both the files into R and checking

# check & set working directory
getwd()
setwd("data")

# read files
library(tidyverse)
library(readr)
math <- read_delim("student-mat.csv", delim = ";", col_names = TRUE, show_col_types = FALSE) #jahas, read_csv:ssä ei pystynyt määrittämään delimiä
por <- read_delim("student-por.csv", delim = ";", col_names = TRUE, show_col_types = FALSE)

#?read_csv()

#check dim and str

dim(math) #395 obs of 33 var
dim(por) #649 obs of 33 var

str(math) #ok
str(por) #ok


########## 4 join the two by other than the 6 "free cols"

# access the dplyr package
library(dplyr)

# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))



######### 5 get rid of duplicates

alc <- select(math_por, all_of(join_cols))

# as in excercise 3.3
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else { 
    alc[col_name] <- first_col #this is funny, just taking the first one of the values...
  }
}


######### 6 alc_use and high_use

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)


########## 7

# glimpse at the new combined data and write it into file

glimpse(alc)

write_csv(alc, "alc.csv")



######### ALL DONE

