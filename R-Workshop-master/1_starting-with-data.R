# ---
# title: Starting with Data
# author: Justin Ho, The Carpentries
# last updated: 15/05/2019
# credit: Adapted from Data Carpentry workshops (Social Science Curriculum)
# ---

####################################################################################
## Setting Up                                                                     ##
####################################################################################
# You are going load the data in R's memory using the function `read_csv()`
# from the `readr` package which is part of the **`tidyverse`**. 
# So, before we can use the `read_csv()` function, we need to load the package. 
# The missing data is encoded as "NULL" in the dataset. 
library(tidyverse).
# To set the working directory, you can do: Session -> Set Working Directory -> Choose Directory...
# Or you can type the path to the directory.
setwd("/Volumes/adiaslo/CDF/Placement/R-Workshop-master") # you need to change the path
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")


####################################################################################
## What are data frames?                                                          ##
####################################################################################

## What are data frames?
# - the representation of data in the format of a table
# - columns are variables that all have the same length
# - each column must contain a single type of data

## Inspecting data frames
# There are functions to extract this information from data frames.
# Here is a non-exhaustive list of some of these functions:
# 
# Size:
dim(interviews) # returns number of rows, number of columns
nrow(interviews) # returns the number of rows
ncol(interviews) # returns the number of columns

# Content:
head(interviews) # shows the first 6 rows
tail(interviews) # shows the last 6 rows

# Names:
names(interviews) # returns the column names (same as 'colnames()')

# Summary:
str(interviews) # structure of the object and information about the class, length and content of each column
summary(interviews) # summary statistics for each column


####################################################################################
## Indexing and subsetting data frames                                            ##
####################################################################################

## first element in the first column of the data frame
interviews[1, 1]

## first column of the data frame
interviews[, 1]

## first column of the data frame
interviews[1]

## first three elements in the 7th column
interviews[1:3, 7]

## the 3rd row of the data frame
interviews[3, ]

## equivalent to head(interviews)
interviews[1:6, ]
interviews[-c(7:131), ]

# The whole data frame, except the first column
interviews[, -1]          

# Data frames can be subset by calling indices (as shown previously), 
# but also by calling their column names directly:

interviews["village"]       # Result is a data frame
interviews[, "village"]     # Result is a data frame
interviews[["village"]]     # Result is the values in the variable
interviews$village          # Result is the values in the variable

########## Exercise ########## 
# 1. Create a data frame (`interviews_100`) containing only the data in
#    row 100 of the `surveys` dataset.
# 2. Notice how `nrow()` gave you the number of rows in a data frame?
#      * Use that number to pull out just that last row in the data frame.
#      * Compare that with what you see as the last row using `tail()` to make
#        sure it's meeting expectations.
#      * Pull out that last row using `nrow()` instead of the row number.
#      * Create a new data frame (`interviews_last`) from that last row.
# 3. Use `nrow()` to extract the row that is in the middle of the data frame.
#    Store the content of this row in an object named `interviews_middle`.
# 4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
#    `head(interviews)`, keeping just the first through 6th rows of the interviews
#    dataset.

############################## 

####################################################################################
## Factors                                                                        ##
####################################################################################

## Factors:
# - represent categorical data
# - stored as integers associated with labels 
# - can be ordered or unordered. 
# - look like character variables, but actually treated as integer variables

# Once created, factors can only contain a pre-defined set of values, known as
# *levels*. By default, R always sorts levels in alphabetical order. For
# instance, if you have a factor with 2 levels:
respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
respondent_floor_type

# R will assign `1` to the level `"cement"` and `2` to the level `"earth"`
# (because `c` comes before `e`, even though the first element in this vector is
# `"earth"`). You can see this by using the function `levels()` and you can find
# the number of levels using `nlevels()`:

levels(respondent_floor_type)
nlevels(respondent_floor_type)

# Reordering
respondent_floor_type # current order
respondent_floor_type <- factor(respondent_floor_type, levels = c("earth", "cement"))
respondent_floor_type # after re-ordering

# Renaming levels 
# Let's say we made a mistake and need to recode "cement" to "brick".
levels(respondent_floor_type)

levels(respondent_floor_type)[2] <- "brick"
levels(respondent_floor_type)

respondent_floor_type

# Converting a factor to a character vector
as.character(respondent_floor_type)

# Converting factors where the levels appear as numbers to a numeric vector
# It's a little trickier!
# The `as.numeric()` function returns the index values of the factor, not its levels

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)                     # Wrong! And there is no warning...
as.numeric(as.character(year_fct))       # Works...
as.numeric(levels(year_fct))[year_fct]   # The recommended way.

# Notice that in the recommended `levels()` approach, three important steps occur:
# 1. We obtain all the factor levels using `levels(year_fct)`
# 2. We convert these levels to numeric values using `as.numeric(levels(year_fct))`
# 3. We then access these numeric values using the underlying integers of the vector `year_fct`


####################################################################################
## Renaming factors                                                               ##
####################################################################################
# When your data is stored as a factor, you can use the `plot()` function to get a
# quick glance at the number of observations represented by each factor level:

# create a vector from the data frame column "memb_assoc"
memb_assoc <- interviews$memb_assoc
# convert it into a factor
memb_assoc <- as.factor(memb_assoc)
# let's see what it looks like
memb_assoc

plot(memb_assoc)

# Including missing data.
# Let's recreate the vector from the data frame column "memb_assoc"
memb_assoc <- interviews$memb_assoc
# replace the missing data with "undetermined"
memb_assoc[is.na(memb_assoc)] <- "undetermined"
# convert it into a factor
memb_assoc <- as.factor(memb_assoc)
# let's see what it looks like
memb_assoc

plot(memb_assoc)

########## Exercise ########## 
# * Rename the levels of the factor to have the first letter in uppercase:
#   "No","Undetermined", and "Yes". 
# * Now that we have renamed the factor level to "Undetermined", can you
#   recreate the barplot such that "Undetermined" is last (after "Yes")?

##############################