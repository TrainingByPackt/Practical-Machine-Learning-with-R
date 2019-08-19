install.packages("itunesr")
install.packages("textfeatures")
install.packages("tidyverse")

library(itunesr)
library(textfeatures)
library(tidyverse)

## the text is a review of a product
text_data <- c(
  "This product was delivered very fast",
  "IT'S A GREAT DAY TODAY!",
  paste("The product works very efficiently"),
  paste("The product saves us a lot of time"),
  paste("The seller arranged a timely delivery")
)

## get the text features of a sample character vector
textfeatures(text_data)

## data frame with a character vector named "text"
df <- data.frame(
  id = c(1, 2, 3),
  text = c("this is A!\t sEntence https://github.com about #rstats @github",
           "and another sentence here",
           "The following list:\n- one\n- two\n- three\nOkay!?!"),
  stringsAsFactors = FALSE
)

## Generate the text features
features=textfeatures(df)

#print the text features
glimpse(features)

