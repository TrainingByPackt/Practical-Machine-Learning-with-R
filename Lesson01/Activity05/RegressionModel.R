#Build multi variable regression
regression <- lm(medv~crim + indus+rad , data = BostonHousing)


#View the summary
summary(regression)


#Plot the fit
plot(regression)

