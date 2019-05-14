
#Subsetting Data
# select variables mpg, cyl, disp
myvars <- c("mpg", "cyl", "disp")
newdata <- mtcars[myvars]
head(newdata)

# another method
newdata <- mtcars[, 1:3]
head(newdata)

# select 1st and 5th thru 10th variables
newdata <- mtcars[c(1,5:10)]
head(newdata)

# using subset function 
newdata <- subset(mtcars, mpg >= 20 & cyl < 5, 
                  select=c(mpg, cyl))
head(newdata)
