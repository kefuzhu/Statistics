# HW 5 - Due Tuesday October 4, 2016 in moodle and hardcopy in class. 
# Upload R file to Moodle with name: HW5_490IDS_YourClassID.R
# Do Not remove any of the comments. These are marked by #

# Please ensure that no identifying information (other than yur class ID) 
# is on your paper copy, including your name

#For this problem we will start with a simulation in order to find out how large n needs
#to be for the binomial distribution to be approximated by the normal
#distribution. 

#We will take m samples from the binomial distribution for some n and p.
#1.(4pts.) Let's let p=1/2, use the rbinom function to generate the sample of size m. 
#Add normal curves to all of the plots. 
#Use 3 values for n, 10, 30, and 50. Display the histograms as well as your
#code below. 

m <- 250
n_10 <- rbinom(n = m, size = 10, p = 1 / 2)
n_30 <- rbinom(n = m, size = 30, p = 1 / 2)
n_50 <- rbinom(n = m, size = 50, p = 1 / 2)
x <- seq(0,100,0.1)

hist(n_10,probability = TRUE)
curve(dnorm(x,mean=mean(n_10),sd=sd(n_10)),add=TRUE)

hist(n_30,probability = TRUE)
curve(dnorm(x,mean=mean(n_30),sd=sd(n_30)),add=TRUE)

hist(n_50,probability = TRUE)
curve(dnorm(x,mean=mean(n_50),sd=sd(n_50)),add=TRUE)

#1b.)(3pts.) Now use the techniques described in class to improve graphs. 
# Explain each step you choose including why you are making the change. You
# might consider creating density plots, changing color, axes, labeling, legend, and others for example.

# Create histogram of n = 10
hist(n_10,
     prob = TRUE,
     xlab = 'Number of successes',
     ylab = 'Probability',
     main = 'Histogram of successes from 10 trials with probability of 0.5')
curve(dnorm(x,mean=mean(n_10),sd=sd(n_10)),add=TRUE,col = 'Red',lwd=3)
# Add the density curve of actual data
lines(density(n_10),lty='dotted',lwd=3,col='Blue')
# Add legend
legend(legend = c('Normal Curve','Density Curve'), fil = c('Red','Blue'), 'topright')

# Create histogram of n = 30
hist(n_30,
     prob = TRUE,
     xlab = 'Number of successes',
     ylab = 'Probability',
     main = 'Histogram of successes from 30 trials with probability of 0.5')
curve(dnorm(x,mean=mean(n_30),sd=sd(n_30)),add=TRUE,col = 'Red',lwd=3)
# Add the density curve of actual data
lines(density(n_30),lty='dotted',lwd=3,col='Blue')
# Add legend
legend(legend = c('Normal Curve','Density Curve'), fil = c('Red','Blue'), 'topright')

# Create histogram of n = 50
hist(n_50,
     prob = TRUE,
     xlab = 'Number of successes',
     ylab = 'Probability',
     main = 'Histogram of successes from 50 trials with probability of 0.5')
curve(dnorm(x,mean=mean(n_50),sd=sd(n_50)),add=TRUE,col = 'Red',lwd=3)
# Add the density curve of actual data
lines(density(n_50),lty='dotted',lwd=3,col='Blue')
# Add legend
legend(legend = c('Normal Curve','Density Curve'), fil = c('Red','Blue'), 'topright')

# Steps
# (1) Make the axes more informative and add title to describe the graph
# (2) Change the color of normal curves to red to distinguish with the histogram
# (3) Make the normal curve wider to be more noticeable
# (4) Add the density curve of actual data to the graph, make it blue dotted line to differentiate it from the normal curve
# (5) Add legend to explain different curves

#Q2.) (2pts.)
#Why do you think the Data Life Cycle is crucial to understanding the opportunities
#and challenges of making the most of digital data? Give two examples.

# Answer: (1) Be able to clean the data and extract useful information from
#             the data is important for any projects. It is hard to find valuable
#             information from the data if the data is not well-organized.
#             And even the data is well-organized to some level, if people do
#             not know skills and techniques to do data mining, they will overlook
#             many useful information hided behind the data
#         (2) Be aware of preserving the data and document the work properly
#             is also crucial for the use of data in the future. If the data is
#             not well-preserved and the works were not well-documented, it
#             will make either the author himself/herself or other people 
#             hard to understand the code that has been made years ago or
#             try replicate the work

###Part 2###
#3.)  San Francisco Housing Data

# Clear the current workspace
rm(list=ls())

#
# Load the data into R.
load(url("http://www.stanford.edu/~vcs/StatData/SFHousing.rda"))

# (2 pts.)
# What is the name and class of each object you have loaded into your workspace?
### Your code below
# Name of objects
objects()
# Classes of each objects
class(cities)
class(housing)
### Your answer here

# What are the names of the vectors in housing?
### Your code below
names(housing)

### Your answer here

# How many observations are in housing?
### Your code below
dim(housing)[1]
### Your answer here

# Explore the data using the summary function. 
# Describe in words two problems that you see with the data.
#### Write your response here
summary(housing)

# Answer: 1. Variable "year" contains zero value
#         2. Variable "year" contains unreasonable extreme value (3894)
#         3. Variable "bsqft" has extreme high value
#         4. Variable "price" has extreme high value

# Q5. (2 pts.)
# We will work the houses in Albany, Berkeley, Piedmont, and Emeryville only.
# Subset the data frame so that we have only houses in these cities
# and keep only the variables city, zip, price, br, bsqft, and year
# Call this new data frame BerkArea. This data frame should have 4059 observations
# and 6 variables.

BerkArea <-
  subset(
    housing,
    city %in% c('Albany', 'Berkeley', 'Piedmont', 'Emeryville'),
    select = c(city, zip, price, br, bsqft, year)
  )

# Remove extra levels in city
BerkArea$city <-factor(BerkArea$city)

# Q6. (2 pts.)
# We are interested in making plots of price and size of house, but before we do this
# we will further subset the data frame to remove the unusually large values.
# Use the quantile function to determine the 99th percentile of price and bsqft
# and eliminate all of those houses that are above either of these 99th percentiles
# Call this new data frame BerkArea, as well. It should have 3999 observations.
BerkArea <-
  BerkArea[BerkArea$price < quantile(BerkArea$price, 0.99) &
           BerkArea$bsqft < quantile(BerkArea$bsqft, 0.99,na.rm = TRUE),]

# Q7 (2 pts.)
# Create a new vector that is called pricepsqft by dividing the sale price by the square footage
# Add this new variable to the data frame.

pricepsqft <- BerkArea$price/BerkArea$bsqft
BerkArea['pricepsqft'] <- pricepsqft

#  Q8 (2 pts.)
# Create a vector called br5 that is the number of bedrooms in the house, except
# if this number is greater than 5, it is set to 5.  That is, if a house has 5 or more
# bedrooms then br5 will be 5. Otherwise it will be the number of bedrooms.

br5 <- BerkArea$br
br5[br5>5]<-5

# Q9 (4 pts. 2 + 2 - see below)
# Use the rainbow function to create a vector of 5 colors, call this vector rCols.
# When you call this function, set the alpha argument to 0.25 (we will describe what this does later)
# Create a vector called brCols of 4059 colors where each element's
# color corresponds to the number of bedrooms in the br5.
# For example, if the element in br5 is 3 then the color will be the third color in rCols.

# (2 pts.)
rCols <- rainbow(5,alpha=0.25)
brCols <- rCols[br5]

######
# We are now ready to make a plot.
# Try out the following code
plot(pricepsqft ~ bsqft, data = BerkArea,
     main = "Housing prices in the Berkeley Area",
     xlab = "Size of house (square ft)",
     ylab = "Price per square foot",
     col = brCols, pch = 19, cex = 0.5)
legend(legend = 1:5, fill = rCols, "topright")

# (2 pts.)
### What interesting features do you see that you didn't know before making this plot? 

# Answer: Price per square foot is not related to the number of bedrooms or the size of the house at all

# (2 pts.)
# Replicate the boxplots presented in class, with the boxplots sorted by median housing price (slide 45 of the lecture notes)
boxplot(BerkArea$price~BerkArea$city)
title('Cities sorted by median housing price')
