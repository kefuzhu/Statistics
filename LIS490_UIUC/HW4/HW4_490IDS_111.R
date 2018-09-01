# HW 4 Due Tuesday Sept 27, 2016. Upload R file to Moodle with name: HW2_490IDS_YOUR_CLASSID.R
# Notice we are using the new system with your unique class ID. You should have received an email with
# your unique class ID. Please make sure that ID is the only information on your hw that identifies you. 
# Do not remove any of the comments. These are marked by #

### Part 1: Linear Regression Concepts
## These questions do not require coding but will explore some important concepts
## from lecture 5.

## "Regression" refers to the simple linear regression equation:
##    y = B0 + B1*x
## This homework will not discuss any multivariate regression.

## 1. (1 pt)
## What is the interpretation of the coefficient B1? 
## (What meaning does it represent?)

## Your answer

# Answer: The value of y is expected to increase by B1 units 
#         if the value of x is increased by 1 unit.

## 2. (1 pt)
## If the residual sum of squares (RSS) of my regression is exactly 0, what does
## that mean about my model?

## Your answer

# Answer: All data points are exactly on the linear regression model.
#         In other words, the model explained 100% of the data.

## 3. (2 pt)
## Outliers are problems for many statistical methods, but are particularly problematic
## for linear regression. Why is that? It may help to define what outlier means in this case.
## (Hint: Think of how residuals are calculated)

## Your answer

# Answer: Because the model is fitted based on least sum of squares criterion,
#         which is calculated by summing all squares of residuals, so if an outlier
#         exists, it will have large value of residual, and it is especially
#         influential for the model since the value of residual square is used to determine the coefficients.

### Part 2: Sampling and Point Estimation

## The following problems will use the ggplot2movies data set and explore
## the average movie length of films in the year 2000.

## Load the data by running the following code
install.packages("ggplot2movies")
library(ggplot2movies)
data(movies)

## 4. (2 pts)
## Subset the data frame to ONLY include movies released in 2000.
movies <- subset(movies, movies$year == 2000)

## Use the sample function to generate a vector of 1s and 2s that is the same
## length as the subsetted data frame. Use this vector to split
## the 'length' variable into two vectors, length1 and length2.

## IMPORTANT: Make sure to run the following seed function before you run your sample
## function. Run them back to back each time you want to run the sample function.


## Check: If you did this properly, you will have 1035 elements in length1 and 1013 elements
## in length2.

set.seed(1848)
# sample(...)

# Store the sample result into a temporary vector
tmp <- sample(c(1, 2), size = length(movies[, 1]), replace = TRUE)
# Split the 'length' variable based on values in the temporary vector
length1 <- movies$length[tmp == 1]
length2 <- movies$length[tmp == 2]

## 5. (3 pts)
## Calculate the mean and the standard deviation for each of the two
## vectors, length1 and length2. Use this information to create a 95% 
## confidence interval for your sample means. Compare the confidence 
## intervals -- do they seem to agree or disagree?

## Your answer here
mean_1 <- mean(length1)
mean_2 <- mean(length2)
SD_1 <- sd(length1)
SD_2 <- sd(length2)
confidence_interval_1 <- c(mean_1 - 1.96 * SD_1, mean_1 + 1.96 * SD_1)
confidence_interval_2 <- c(mean_2 - 1.96 * SD_2, mean_2 + 1.96 * SD_2)
mean_1
mean_2
confidence_interval_1
confidence_interval_2
# Answer: Since both intervals contain the the two sample means and the ranges of both intervals do not have a big difference, 
#         these two confidence intervals seem to agree.


## 6. (4 pts)
## Draw 100 observations from a standard normal distribution. Calculate the sample mean.
## Repeat this 100 times, storing each sample mean in a vector called mean_dist.
## Plot a histogram of mean_dist to display the sampling distribution.
## How closely does your histogram resemble the standard normal? Explain why it does or does not.

## Your answer here
mean_dist <- c()
for (i in 1:100) {
  mean_dist[i] <- mean(rnorm(100, mean = 0, sd = 1))
}
hist(
  mean_dist,
  breaks = 100,
  density = 40,
  main = 'Histogram of Sample Means',
  xlab = 'Mean'
)

# Answer: The histogram looks close to the standard normal distribution but not it is still different.
#         If we draw more observations each time and repeat the process even more times, 
#         the histogram will closer to the standard normal distribution

## 7. (3 pts)
## Write a function that implements Q6.

## Your answer here

HW.Bootstrap=function(distn,n,reps){
  set.seed(1848)
  
  #more lines here
  if(is.function(distn)!=TRUE) stop('Please provide a valid function')
  else if(is.numeric(n) & is.numeric(reps) == FALSE) stop('Please provide a number for randomization')
  else if(n < 0) stop ('Please provide a positive number of observations')
  else if(reps <0) stop ('Please provide a positvie number of repeats')
  else{
    mean_dist <- c()
    for (i in 1:reps) {
      mean_dist[i] <- mean(distn(n, mean = 0, sd = 1))
    }
    hist(mean_dist, breaks = reps, density = 40, main = 'Histogram of Sample Means', xlab = 'Mean')
  }
}
# Show case
HW.Bootstrap(rnorm,100,100)

### Part 3: Linear Regression
## This problem will use the Boston Housing data set.
## Before starting this problem, we will declare a null hypthosesis that the
## crime rate has no effect on the housing value for Boston suburbs.
## That is: H0: B1 = 0
##          HA: B1 =/= 0
## We will attempt to reject this hypothesis by using a linear regression


# Load the data
housing <- read.table(url("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"),sep="")
names(housing) <- c("CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT","MEDV")

## 7. (2 pt)
## Fit a linear regression using the housing data using CRIM (crime rate) to predict
## MEDV (median home value). Examine the model diagnostics using plot(). Would you consider this a good
## model or not? Explain.
attach(housing)
fit <- lm(MEDV~CRIM)
par(mfrow = c(2,2))
plot(fit)

# Answer: Based on the dignostic plots, the data does not seem to be normally distributed
# and it also has problem of heteroscedasticity. Furthermore, the data also contains an outlier.
# So this is not a good model.

## 8. (2 pts)
## Using the information from summary() on your model, create a 95% confidence interval 
## for the CRIM coefficient 
c(
  summary(fit)$coefficients[, 1]['CRIM'] - 1.96 * summary(fit)$coefficients[, 2]['CRIM'],
  summary(fit)$coefficients[, 1]['CRIM'] + 1.96 * summary(fit)$coefficients[, 2]['CRIM']
)

## 9. (2 pts)
## Based on the result from question 8, would you reject the null hypothesis or not?
## (Assume a significance level of 0.05). Explain.

## Your answer

# Answer: Yes. I will reject the null hypothesis because 
# zero is not in the 95% confidence interval of CRIM coefficient.

## 10. (1 pt)
## Pretend that the null hypothesis is true. Based on your decision in the previous
## question, would you be committing a decision error? If so, which one?

## Your answer

# Answer: I will make a Type I Error

## 11. (1 pt)
## Use the variable definitions from this site:
## https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.names
## Discuss what your regression results mean in the context of the data (using appropriate units)
## (Hint: Think back to Question 1)

## Your answer

# Answer: If the per capita crime rate by town increases by 1%, 
# the median value of owner-occupied homes is expected to decrease by 4.1519 dollars.

## 12. (2 pt)
## Describe the LifeCycle of Data for Part 3 of this homework.

# Answer: The data is first obtained from UCI machine learning database,
#         then the informative names are assigned to variables in the original dataset.
#         Finally, the data is used for linear regression analysis which involes checking assumptions
#         and interpreting results.
