# Load dplyr, tidyr, stringr, readr packages
library(dplyr)
library(tidyr)
library(stringr)
library(readr)

# Load "titanic_original.csv" dataset into titanic_df
path <- file.path("Titanic Data", "titanic_original.csv")
titanic_df <- read_csv(path)

# Determine the number of missing values in embarked and how they are coded
titanic_df %>% group_by(embarked) %>% summarise(n()) # Coded as empty strings

# Replace empty strings with "S" in embarked vector
titanic_df$embarked[titanic_df$embarked == ""] <- "S"

# Determine the number of missing age values in titanic_df
summary(titanic_df$age)

# Put mean age of titanic_df into an object
mean_age <- mean(titanic_df$age, na.rm = TRUE)

# Replace all NA's in age vector with mean_age
titanic_df$age[is.na(titanic_df$age)] <- mean_age

# Determine the coding of missing values for boat
unique(titanic_df$boat) # Coded as empty strings

# Replace empty strings with NA in boat vector
titanic_df$boat[titanic_df$boat == ""] <- NA

# Determine the coding of missing values for cabin
unique(titanic_df$cabin) # Coded as empty strings

# Create has_cabin_number dummy variable in data frame
titanic_df <- titanic_df %>% mutate(has_cabin_number = as.numeric(cabin != ""))

# Save data frame
write.csv(titanic_df, file = "titanic_clean.csv")
