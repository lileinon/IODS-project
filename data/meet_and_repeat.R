# Leinonen
# IODS7 2022
# 12.12.2022
# Data Wrangling


######### 1 ######### Read in the data, check its structure etc

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", 
                   header = TRUE, sep = '\t')

str(BPRS) 
str(RATS)

summary(BPRS)
summary(RATS)

######### 2 ######### convert categorical variables to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

######### 3 ######### convert to long form; add Week-variable to BPRS and Time-var to RATS

BPRS <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  arrange(weeks) 




RATS <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)


######### 4 ######### Serious look

View(BPRS)
View(RATS)

glimpse(BPRS)
glimpse(RATS)

summary(BPRS)
summary(RATS)


# Done, understood the difference between wide and long.

# Not mentioned in the data wrangling guidelines, but I'll save the results as csv:s for later use

library(tidyverse)
write_csv(BPRS, "data/bprs.csv")
write_csv(RATS, "data/rats.csv")

