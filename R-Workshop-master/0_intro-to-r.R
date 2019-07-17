# ---
# title: Introduction to R
# author: Justin Ho, The Carpentries
# last updated: 15/05/2019
# credit: Adapted from Data Carpentry workshops (Social Science Curriculum)
# ---

####################################################################################
## Creating objects in R                                                          ##
####################################################################################

# You can get output from R simply by typing math in the console.
# 
# However, to do useful and interesting things, we need to assign values to
# objects. To create an object, we need to give it a name followed by the
# assignment operator `<-`, and the value we want to give it:
# 
# In RStudio, typing 'Alt' + '-' will write `<- ` in a single keystroke in a
# PC, while typing 'Option' + '-' does the same in a Mac.
# 
# Objects Name:
# - Any name such as `x`, `current_temperature`, or `subject_id`
# - Explicit and not too long. 
# - Cannot start with a number (`2x` is not valid, but `x2` is).
# - Case sensitive
# - Names of fundamental functions can't be used (eg 'if', 'else', 'for')
# - Best to not use other function names (e.g., `c`, `T`, `mean`, `data`, `df`, `weights`)
# - Recommended to use nouns for object names, and verbs for function names.
# - Popular coding style guides: Google's (https://google.github.io/styleguide/Rguide.xml), Jean Fan's (http://jef.works/R-style-guide/) and the tidyverse's (http://style.tidyverse.org/).

# When assigning a value to an object, R does not print anything. You
# can force R to print the value by using parentheses or by typing
# the object name:

area_hectares <- 1.0    # doesn't print anything
(area_hectares <- 1.0)
area_hectares
 
# Now that R has `area_hectares` in memory, we can do arithmetic with it. For
# instance, we may want to convert this area into acres (area in acres is 2.47 times the area in hectares):

2.47 * area_hectares
 
# We can also change an object's value by assigning it a new one:
area_hectares <- 2.5
2.47 * area_hectares

# Assigning a value to one object does not change the values of
# other objects  For example, let's store the plot's area in acres
# in a new object, `area_acres`:

area_acres <- 2.47 * area_hectares

# and then change `area_hectares` to 50.

area_hectares <- 50

########## Question: ########## 
# What do you think is the current content of the object `area_acres`? 123.5 or 2.47?

###############################

####################################################################################
## Comments                                                                       ##
####################################################################################
# All programming languages allow the programmer to include comments in their code. 
# To do this in R we use the `#` character.
# Anything to the right of the `#` sign and up to the end of the line is treated 
# as a comment and is ignored by R. You can start lines with comments
# or include them after any code on the line.

area_acres <- area_hectares * 2.47	# convert to acres
area_acres				# print land area in acres.

## Tips:
# RStudio makes it easy to comment or uncomment a paragraph: after selecting the
# lines you  want to comment, press at the same time on your keyboard
# 'Ctrl' + 'Shift' + 'C'. 

 
########## Exercise ########## 
# Create two variables `length` and `width` and assign them values.
# Create a third variable `area` and give it a value based on 
# the current values of `length` and `width`.

##############################

####################################################################################
## Functions and their arguments                                                  ##
####################################################################################

## Functions:
# - Functions are "canned scripts"
# - Predefined, or can be made available by importing R *packages*
# - A function usually gets one or more inputs called *arguments*
# - Can return a single value, and also a set of things, or even a dataset 

# Example:
b <- sqrt(100)

## Arguments:
# - can be anything (numbers, filenames, objects etc)
# - must be looked up in the documentation
# - Some functions take on a *default* value

# Let's try a function that can take multiple arguments: `round()`.

round(3.14159)

# Here, we've called `round()` with just one argument, `3.14159`, and it has
# returned the value `3`.  That's because the default is to round to the nearest
# whole number. If we want more digits we can see how to do that by getting
# information about the `round` function.  We can use `args(round)` or look at the
# help for this function using `?round`.

args(round)
?round

# We see that if we want a different number of digits, we can
# type `digits=2` or however many we want.

round(3.14159, digits = 2)

# If you provide the arguments in the exact same order as they are defined you
# don't have to name them:

round(3.14159, 2)

# And if you do name the arguments, you can switch their order:

round(digits = 2, x = 3.14159)

# It's good practice to put the non-optional arguments (like the number you're
# rounding) first in your function call, and to specify the names of all optional
# arguments.  If you don't, someone reading your code might have to look up the
# definition of a function with unfamiliar arguments to understand what you're
# doing.

####################################################################################
## Variables and data types                                                       ##
####################################################################################

## Variables
# - composed by a series of values, can be either numbers or characters. 
# - can be assigned using the `c()` function.

# For example, we can create a variable of household members for the households 
# we've interviewed and assign it to a new object `no_membrs`:

no_membrs <- c(3, 7, 10, 6)
no_membrs

# A variable can also contain characters. For example, we can have
# a variable of the building material used to construct our
# interview respondents' walls (`respondent_wall_type`):

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type

# The quotes around "muddaub", etc. are essential here. Without the quotes R
# will assume there are objects called `muddaub`, `burntbricks` and `sunbricks`. 
# As these objects don't exist in R's memory, there will be an error message.

# There are many functions that allow you to inspect the content of a
# variable. `length()` tells you how many elements are in a particular variable:

length(no_membrs)
length(respondent_wall_type)

# An important feature of a variable, is that all of the elements are the same type of data.
# The function `class()` indicates the class (the type of element) of an object:

class(no_membrs)
class(respondent_wall_type)

# The function `str()` provides an overview of the structure of an object and its
# elements. It is a useful function when working with large and complex
# objects:

str(no_membrs)
str(respondent_wall_type)

# You can use the `c()` function to add other elements to your variable:

possessions <- c("bicycle", "radio", "television")
possessions

possessions <- c(possessions, "mobile_phone") # add to the end of the variable
possessions

possessions <- c("car", possessions) # add to the beginning of the variable
possessions

########## Exercise ##########
# 1. We’ve seen that variables can be of type character, numeric (or double),
# integer, and logical. But what happens if we try to mix these types in a
# single vector?
# 
# 2. What will happen in each of these examples? 
# (hint: use `class()` to check the data type of your objects):

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

# 3. Why do you think it happens?


##############################

########## Question ##########
# How many values in `combined_logical` are `"TRUE"` (as a character) in the
# following example:

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)



####################################################################################
## Subsetting variables                                                           ##
####################################################################################

# If we want to extract one or several values from a variable, we must provide one
# or several indices in square brackets. For instance:

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type[2]
respondent_wall_type[1:2]
respondent_wall_type[c(3, 2)]
respondent_wall_type[c(1, 2, 3, 2, 1, 3)]
 
# Another common way of subsetting is by using a logical statement. `TRUE` will
# select the element with the same index, while `FALSE` will not:

no_membrs <- c(3, 7, 10, 6)
no_membrs[c(TRUE, FALSE, TRUE, TRUE)]

# Typically, these logical statements are not typed by hand, but are the output of
# other functions or logical tests. For instance, if you wanted to select only the
# values above 5:

no_membrs
no_membrs > 5 
no_membrs[no_membrs > 5]

####################################################################################
## Missing data                                                                   ##
####################################################################################


# Missing data are represented in variables as `NA`.
# Most functions will return `NA` if the data you are working with include missing values. 

rooms <- c(2, 1, 1, NA, 4)
mean(rooms)
max(rooms)

# You can add the argument `na.rm=TRUE` to ignore the missing values.
mean(rooms, na.rm = TRUE)
max(rooms, na.rm = TRUE)

# Extract those elements which are not missing values.
rooms[!is.na(rooms)]

# Returns the object with incomplete cases removed.
na.omit(rooms)
