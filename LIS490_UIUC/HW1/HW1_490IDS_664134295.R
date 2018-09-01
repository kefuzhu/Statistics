# HW 1 Due Tuesday Sept 6, 2016. Upload R file to Moodle with name: HW1_490IDS_YOURUNI.R
# Do Not remove any of the comments. These are marked by #

###Name: Kefu Zhu

# Load the data for this assignment into your R session 
# with the following command:

load(url("http://courseweb.lis.illinois.edu/~jguo24/SFTemps.rda"))

# Check to see that the data were loaded by running:
objects()
# This should show five variables: dates, dayOfMonth, month, temp, and year

# Use the length() function to find out how many observations there are.
length(dates)
# For the following questions, use one of: head(), summary(),
# class(), min(), max(), hist(), quantile() to answer the questions.

# 1. (1) What was the coldest temperature recorded in this time period?
min(temp,na.rm=TRUE)
# 2. (1) What was the average temperature recorded in this time period?
summary(temp)[4]
# 3. (2) What does the distribution of temperatures look like, i.e.
# are there roughly as many warm as cold days, are the temps
# clustered around one value or spread evenly across the range
# of observed temperatures, etc.?
hist(temp,density = 20, breaks = 50)
# Answer: The distribution of temperature follows normal distribution that centers around 58 Farenheit degree.

# 4. (1) Examine the first few values of dates. These are a special
# type of data. Confirm this with class().
head(dates)
class(dates)
# 5. (1) We would like to convert the temperature from Farenheit to Celsius.
# Below are several attempts to do so that each fail.  
# Try running each expression in R. 
# Record the error message in a comment
# Explain what it means. 
# Be sure to directly relate the wording of the error message with the problem you find in the expression.

(temp -32)
### Error message here

# No error message

### Explanation here

# Answer: The calculation is not correct. Every value should times 5/9 based on current calculation.

(temp - 32)5/9
### Error message here

# Error: unexpected numeric constant in "(temp - 32)5"

### Explanation here

# Answer: Syntax error. Missing arithmetic expression after the parentheses.

5/9(temp - 32)
### Error message here

# Error: attempt to apply non-function

### Explanation here

# Answer: Syntax error. Because there is no arithmetic expression after 5/9, R will try to call a function called 5/9.

[temp - 32]5/9
### Error message here

# Error: unexpected '[' in "["

### Explanation here

# Answer: Bracket can be only used for slicing. It is not a data structure that can store the result of an expression.

# 6. (1) Provide a well-formed expression that correctly performs the 
# calculation that we want. Assign the converted values to tempC.

tempC <- (temp-32)*(5/9)

# 7. Run the following code to make a plot.
# (don't worry right now about what this code is doing)

plot(temp~dates, col = rainbow(12)[month], type="p", pch=19, cex = 0.3)

# (1) Use the Zoom button in the Plots window to enlarge the plot.
# Resize the plot so that it is long and short, so it is easier to read.
# Include this plot in the homework your turn in.

# (1) Make an interesting observation about temp in the Bay Area
# based on this plot (something that you couldn't see with
# the calculations so far.)

### Your answer goes here
# Answer: The change in temperature is periodic.

# (1) What interesting question about the weather in the SF Bay Area
# would you like to answer with these data, but don't yet know 
# how to do it? 

### Your answer goes here
# Answer: Under the big picture of gloabal warming, why the range of temperature for a given year is increasing while the average temperature in each month is not increasing.

# For the remainder of this assignment we will work with 
# one of the random number generators in R.


# 8. (5). Use the following information about you to generate
# some random values:  
#a. Use the day of the month you were born for the mean of the normal.
#b.	Use your year of birth for the standard deviation (sd) of the normal curve.
#c.	Generate 5 random values using the parameters from a and b.
#d.	Assign the values to a variable named with your first name.
#e.	Provide the values generated.
Kefu <- rnorm(5, mean = 31, sd = 1995)
Kefu

# 9. (1). Generate a vector called "normsamps" containing
# 100 random samples from a normal distribution with
# mean 2 and SD 1.
normsamps <- rnorm(100, mean = 2, sd = 1)

# 10. (1). Calculate the mean and sd of the 100 values.

### The return values from your computation go here
mean(normsamps)
sd(normsamps)

# 11. (1). Use implicit coercion of logical to numeric to calculate
# the fraction of the values in normsamps that are more than 3.
actual <- sum(normsamps>3)/length(normsamps)
actual

# 12. (1). Look up the help for rnorm.
# You will see a few other functions listed.  
# Use one of them to figure out about what answer you 
# should expect for the previous problem.  
# That is, find the area under the normal(2, 1) curve
# to the right of 3.  This should be the chance of getting
# a random value more than 3. What value do you expect? 
# What value did you get? Why might they be different?
legit <- pnorm(3, mean = 2, sd = 1, lower.tail = FALSE)
legit

# Answer: I expect to get 0.15 but the actual value is 0.1586553. The difference is because of small sample size and the 100 numbers is randomly generated, so the result may vary each time.