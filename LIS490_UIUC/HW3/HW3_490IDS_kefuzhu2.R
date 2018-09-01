# HW 3 - Due Tuesday Sept 20, 2016. Upload R file to Moodle with name: HW3_490IDS_YOURNETID.R
# Do Not remove any of the comments. These are marked by #
# The .R file will contain your code and answers to questions.

#Name: Kefu Zhu

# Main topic: Using the "apply" family function

#Q1 (5 pts)
# Given a function below,
myfunc <- function(z) return(c(z,z^2, z^3%/%2))
#(1) Examine the following code, and briefly explain what it is doing.
y = 2:8
# Answer: It creates a list of integers from 2 to 8 and stores the list in variable y.
myfunc(y)
# Answer: For each element in list y, myfunc turns it into three three elements: 
# the original element, the square of it, and the integer division value of the cubic value divided by 2.
matrix(myfunc(y),ncol=3)
# Answer: It transform the list-presented value from myfunc(y) to a matrix with 3 colummns, 
# where each row represents the outputs from an original element in y.
### Your explanation
#(2) Simplify the code in (1) using one of the "apply" functions and save the result as m.
###code & result
m <- t(sapply(y,myfunc))
#(3) Find the row product of m.
###code & result
apply(m,1,prod)
#(4) Find the column sum of m in two ways.
###code & result
apply(m,2,sum)
colSums(m)
#(5) Could you divide all the values by 2 in two ways?
### code & result
matrix(sapply(m,function(x) return(x/2)),ncol=3)
sweep(m,2,2,"/")
#Q2 (8 pts)
#Create a list with 2 elements as follows:
l <- list(a = 1:10, b = 11:20)
#(1) What is the product of the values in each element?
sapply(l,prod)
#(2) What is the (sample) variance of the values in each element?
sapply(l,var)
#(3) What type of object is returned if you use lapply? sapply? Show your R code that finds these answers.
class(sapply(l,var))
class(lapply(l,var))

# Now create the following list:
l.2 <- list(c = c(21:30), d = c(31:40))
#(4) What is the sum of the corresponding elements of l and l.2, using one function call?
mapply('+',l,l.2)
#(5) Take the log of each element in the list l:
sapply(l,log)
#(6) First change l and l.2 into matrixes, make each element in the list as column,
### your code here
l <- sapply(l,matrix)
l.2 <- sapply(l.2,matrix)
#Then, form a list named mylist using l,l.2 and m (from Q1) (in this order).
### your code here
mylist <- list(l,l.2,m)
#Then, select the first column of each elements in mylist in one function call (hint '[' is the select operator).
### your code here
rapply(mylist, classes = 'matrix', how = 'list', f = function(x) x[, 1, drop = FALSE]) 

#Q3 (3 pts)
# Let's load our friend family data again.
load(url("http://courseweb.lis.illinois.edu/~jguo24/family.rda"))
#(1) Find the mean bmi by gender in one function call.
aggregate(fbmi~fgender, data=data.frame(fbmi,fgender), mean)
#(2) Could you get a vector of what the type of variables the dataset is made of?
sapply(family,class)
#(3) Could you sort the firstName in height descending order?
data.frame(fnames,fheight)[order(data.frame(fnames,fheight)$fheight),]$fnames

#Q4 (2 pts)
# There is a famous dataset in R called "iris." It should already be loaded
# in R for you. If you type in ?iris you can see some documentation. Familiarize 
# yourself with this dataset.
#(1) Find the mean petal length by species.
### code & result
aggregate(Petal.Length~Species, data = iris, mean)
#(2) Now obtain the sum of the first 4 variables, by species, but using only one function call.
### code & result
aggregate(.~Species, data = iris, sum)

#Q5 (2 pts)
#Below are two statements, their results have different structure, 
lapply(1:4, function(x) x^3)
sapply(1:4, function(x) x^3)
# Could you change one of them to make the two statements return the same results (type of object)?
unlist(lapply(1:4, function(x) x^3))

#Q6. (5 pts) Using the family data, fit a linear regression model to predict 
# weight from height. Place your code and output (the model) below. 
fit <- lm(fweight~fheight)
par(mfrow = c(2,2))
plot(fit)
summary(fit)
# How do you interpret this model?
# Answer: Based on the previous diagnostic plots, no assumptions are obviously violated.
# The linear model is valid. Based on the summary of fitted linear model, the weight of a person
# is expected to increase by 9.154 units if the height of that person is increased by 1 unit.

# Create a scatterplot of height vs weight. Add the linear regression line you found above.
par(mfrow = c(1,1))
plot(fweight ~ fheight, xlab = 'Weight', ylab = 'Height')
abline(fit)
# Provide an interpretation for your plot.
# Answer: The plot indicates a positive linear relationship between fheight and fweight.
# And the line in the plot is the best fitted linear regression model with least sum of square of residuals.
