# ---
# title: Data Visualisation using ggplot2
# author: Justin Ho
# last updated: 19/05/2019
# ---

####################################################################################
## Loading dataset into R and basic exploration                                   ##
####################################################################################

# The following code will load a dataset into R's memory and stored an object named 'snp'.
snp <- read_csv("data/snp.csv") # Load the file 'snp.csv', put it as an object called 'snp'

# Let's conduct some basic exploration
# The 'head()' function will return the first sixth element of an object:
head(snp)

# find out the number of rows and number of columns
dim(snp) 

# structure of the object and information about the class, length and content of each column
str(snp) 

# summary statistics for each column
summary(snp)

# change the variables to the right format
snp$date <- as.Date(snp$date)
snp$type <- as.factor(snp$type)
snp$sentiment <- as.factor(snp$sentiment)

# try again
summary(snp)

# We could use functions to gain information from the vector
# For example, 'mean()' will gives us the mean, 'max()' will give us the maximun value
max(snp$likes_count_fb)
mean(snp$likes_count_fb)

# We could use 'table()' to get frequency table
table(snp$type)
prop.table(table(snp$type)) # To show in precentage instead of count.

# For more advanced usage of functions, we could use 'which.max()' 
# to identify the element that contains the maximum value
which.max(snp$likes_count_fb)

# The result is 667, meaning that the 667th post of the dataset has the most likes.
# We can then use the slicing operator ('[' and ']') to find the post:
snp[667, ]

# We can combine them into one single line:
snp[which.max(snp$likes_count_fb), ]

########## Exercise ########## 
# Find out which post has most comments 
# # Find out which post has most shares 
##############################

####################################################################################
## Data visualisation with ggplot2                                                ##
####################################################################################
# We start by loading the required package.
# install.packages("ggplot2") # You only have to run it once
library(ggplot2)

# Building plots with **`ggplot2`** is typically an iterative process. 
# We start by defining the dataset we'll use:
ggplot(data = snp)

# lay out the axis(es), for example we can set up the axis for the Comments count ('comments_count_fb'):
ggplot(data = snp, aes(x = comments_count_fb)) 

# and finally choose a geom
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram()

# We could change the binwidth by adding arguments
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100)

# We could add a line showing the mean value by adding a geom
# First we calculate the mean values:
mean_like <- mean(snp$likes_count_fb)
mean_comment <- mean(snp$comments_count_fb)
mean_share <- mean(snp$shares_count_fb)

ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100) +
  geom_vline(xintercept=mean_comment, color = "red", linetype = "dashed")

# We could change color by adding arguments (fill means color of the filling in ggplot2)
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100, fill = "red")

# How about making it transparent?
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(binwidth = 100, fill = "red", alpha = 0.5)

# Instead of colouring everything with the same colour, we could colour them by type 
# since we are using a variable in the dataframe, we have to put it inside aes()
ggplot(data = snp, aes(x = comments_count_fb, fill = type)) +
  geom_histogram(binwidth = 100, alpha = 0.5)

# Remember aesthetic mappings can also be set in individual layers
# In this case the 'fill' will only apply to geom_histogram (even if there are more geoms)
ggplot(data = snp, aes(x = comments_count_fb)) +
  geom_histogram(aes(fill = type), binwidth = 100, alpha = 0.5)

########## Exercise ########## 
# Using the codes above, create a histogram for Likes count ('likes_count_fb')
##############################

####################################################################################
## Visualising categorical variables                                              ##
####################################################################################
# Barplots are also useful for visualizing categorical data. By default,
# `geom_bar` accepts a variable for x, and plots the number of instances each
# value of x (in this case, post type) appears in the dataset.

# We could create a bar plot:
ggplot(snp, aes(x = type)) + 
  geom_bar()

# We can use the `fill` aesthetic for the `geom_bar()` geom to color bars by
# the portion of sentiment of each post type.
ggplot(snp, aes(x = type, fill = sentiment)) + 
  geom_bar()

# We can change how these bars are placed, 
# for example 'position = "dodge"' will place them side by side
ggplot(snp, aes(x = type, fill = sentiment)) + 
  geom_bar(position = "dodge")

# If we use 'position = "fill"', all bar will strech out to fill the whole y axis
# The y axis then become proportion
ggplot(snp, aes(x = type, fill = sentiment)) + 
  geom_bar(position = "fill") +
  labs(y = "proportion")

####################################################################################
## Visualising continuous and categorical variable                                ##
####################################################################################
# We can use boxplots to visualize the comment count for each post type:
# Remember the continous variable always go to y
ggplot(snp, aes(x = type, y = comments_count_fb)) +
  geom_boxplot()

# We could also add points to a boxplot to have a better idea of the number of
# measurements and of their distribution:
ggplot(snp, aes(x = type, y = comments_count_fb)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")

########## Exercise ########## 
# Create a boxplot for `valence` for each post type. Overlay the boxplot
# layer on a jitter layer to show actual measurements (the ordering matters!).
# - Color the data points on your jitter layer by sentiment (`sentiment`).
# Remember you can add aes() inside a geom_*
############################## 

####################################################################################
## Visualising two continuous variables                                           ##
####################################################################################

# Creating a plot for two continuous variables (comments and likes):
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb))

# We could use geom_point() for scatter plot
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point()

# Again, you can add the mean values 
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point() +
  geom_vline(xintercept = mean_comment) +
  geom_hline(yintercept = mean_like)

# You can even add the same geom twice, with different values on the x and y axes
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point() +
  geom_point(aes(x = mean_comment, y = mean_like), color = "red", size = 6)

# Use the argument 'color = "red"' for red dots
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point(color = "red")

# Or coloring them by post type, we have to put it inside aes() since we are invoking a variable
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point() 

# There are many things you can do by adding layers into the ggplot
# You could log them.
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) + # I made the points transparent for visiblity
  scale_x_log10() +
  scale_y_log10()

# And add labels and legend
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "Comments Count", y = "Likes Count",
     title = "Comments and Likes",
     subtitle = "One post per dot")

# Change the theme by adding theme_bw()
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot") + 
  theme_bw()

# To save your graph, you could first define the graph as an object then use ggsave:
myplot <- ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb, color = type)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Comments Count", y = "Likes Count",
       title = "Comments and Likes",
       subtitle = "One post per dot")
ggsave(myplot, filename = "my_plot.png")

# Facet to make small multiples
ggplot(data = snp, aes(x = comments_count_fb, y = likes_count_fb)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  theme_bw() +
  facet_wrap(~ type)

########## Exercise ########## 
# Make a scatter plot of shares by comments count, log both axes,
# color them by post type, change shape by post type (adding 'shape = type ' in aes())
##############################

####################################################################################
## What's next?                                                                   ##
####################################################################################

# You won't be able to learn everything about R in three hours,
# but I hope this workshop would give you a head start in your progarmming journey.
# If you would like to learn more, there are plenty (free) resources online:
# https://www.tidyverse.org/
# http://www.cookbook-r.com/
# https://socviz.co/
