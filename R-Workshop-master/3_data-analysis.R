# ---
# title: Data Analysis
# author: Alice Dias Lopes
# last updated: 16/07/2019
# ---

####################################################################################
##                              4.Data Analysis                                  ##
####################################################################################

# R Basics ---------------------------------------------------------------------
snp <- read.csv("data/snp.csv")
names(snp) # names variables in the data frame.
search() # shows what is in the current R environment.
attach(snp) # attach the dataset to the R environment. once you have attached the data in the environment, you can just use variables
# within your data frame like any other R objects - just calling them by their name. Before attaching the data, you needed 
# to type snp$name. However, if you are working with several data frames with the same variables names, attach may cause 
# you a lot of problems.
search() # you will see that the data frame will be in your R environment.      
detach(snp) # detach the data frame.
# rm(list = ls()) # remove all objects from environment.

# Stats Basics ---------------------------------------------------------------------
### mean
sum(snp$likes_count_fb)/length(snp$likes_count_fb) # caculate the sum of the variable and dived it by the length.
mean(snp$likes_count_fb)

### median
length(snp$likes_count_fb)/2 # calculate the length of the variable and dived by two.
sort(snp$likes_count_fb)[862] # sort the variable for likes count on Facebook and returns the 862 value.
median(snp$likes_count_fb)

### variance and standard deviation
var(snp$likes_count_fb)
sd(snp$likes_count_fb)

### quantile
quantile(snp$likes_count_fb)

### summary function
summary(snp$likes_count_fb)

### tables
table1 <- table(snp$type, snp$sentiment) # type will be rows, sentiment will be columns 
table1 # print table 

# proportion
prop.table(table1) # cell percentages
prop.table(table1, 1) # row percentages 
prop.table(table1, 2) # column percentages

# percentage
100*prop.table(table1,1)
100*prop.table(table1,2)

# rounding by 2 decimal places
round(100*prop.table(table1,1),2)
round(100*prop.table(table1,2),2)

# LMs ---------------------------------------------------------------------

# REGRESSION:
# let's perform a regression of number of likes on Facebook post by comments and sentiment. 

# DEPENDENT VARIABLE
# first, let's check the distribution of the dependent variable (you can also try to write the ggplot command):
hist(snp$likes_count_fb) # the variable is not normally distributed.
summary(snp$likes_count_fb)
# logarithm transformation is often used for right skewed data (mean > median).
# you can save the transformed variable in your data frame
snplikes_count_fb2 <- log10(snp$likes_count_fb)         
# or you can simply include the log10 transformation when you are analysis the variable, for example:
library(ggplot2)
ggplot(snp, aes(x=log10(likes_count_fb)))+
  geom_histogram()+
  theme_bw()

# INDEPENDENT VARIABLES
# (1) number of comments
summary(snp$comments_count_fb)
hist(snp$comments_count_fb) # checking the distribution for the independent variable
hist(log10(snp$comments_count_fb)) # checking the transformation for the independent variable
# (2) sentiment
summary(snp$sentiment) # because the variable is a factor, R will automatically create dummies when you run the regression.
# I usually create dummies (it is easier to change reference group, combine categories, etc.) 
# dummy for negative sentiment
snp$negative[snp$sentiment == "negative"] <- 1
snp$negative[snp$sentiment == "neutral"] <- 0
snp$negative[snp$sentiment == "positive"] <- 0
table(snp$negative,snp$sentiment) # checking the recoding is correct

# dummy for negative sentiment
snp$neutral[snp$sentiment == "negative"] <- 0
snp$neutral[snp$sentiment == "neutral"] <- 1
snp$neutral[snp$sentiment == "positive"] <- 0
table(snp$neutral,snp$sentiment) # checking the recoding is correct

########## Exercise ########## 
# Create a dummy variable for positive sentiment
##############################

#### MODEL 1:
# scatter plot with the regression line using ggplot2
ggplot(snp, aes(x=log10(comments_count_fb), y=log10(likes_count_fb)))+
  geom_point()+
  geom_smooth(method='lm', se = FALSE) +
  theme_bw()

# regression model
lm1 <- lm(log10(likes_count_fb) ~ log10(comments_count_fb), data = snp)
summary(lm1)
# checking the residuals
plot(lm1)

 
#### MODEL 2:
lm2 <- lm(log10(likes_count_fb) ~ log10(comments_count_fb) + neutral + positive, data = snp)
summary(lm2)

# presenting the two models.
install.packages("stargazer")
library(stargazer)
stargazer(lm1, lm2,
          title = "Regression on number of likes on Facebook by comments and sentiment",
          dep.var.labels=c("Log 10 of number of likes on Facebook"),
          covariate.labels=c("log 10 of number of comments","neutral", "positive", "constant"),
          align = TRUE, type = "text", out = "ols_likes_fb.txt")

# GLMs ---------------------------------------------------------------------

# X-SQUARE TEST: 
# difference between the observed cell values and the expected cell values.
table1 <- table(snp$type, snp$sentiment) # table between the two categorical variables in the data frame.
table1
x_square <- chisq.test(table1)
x_square
# you can use the package "gmodels" to calculate the expected values if there was no relatioship between the variables.
install.packages("gmodels")
library(gmodels)
# check the documentation for command CrossTable
?CrossTable
CrossTable(table1, expected = TRUE, prop.r = FALSE, prop.c = FALSE,
           prop.t = FALSE, prop.chisq = FALSE)
