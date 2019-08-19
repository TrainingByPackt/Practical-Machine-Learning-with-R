library(groupdata2)
library(cvms)
library(caret)
library(randomForest)
library(rPref)
library(doParallel)

set.seed(3)

# Load the amsterdam.listings dataset
full_data <- read.csv("amsterdam.listings.csv")

full_data$id <- factor(full_data$id)
full_data$neighbourhood <- factor(full_data$neighbourhood)

summary(full_data)

partitions <- partition(full_data, p = 0.8,
                        cat_col = "room_type")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]

# Register four CPU cores
registerDoParallel(4)

room_type_baselines <- baseline(test_data = valid_set,
                                dependent_col = "room_type",
                                n = 100,
                                family = "binomial",
                                parallel = TRUE)
# Inspect summarized metrics
room_type_baselines$summarized_metrics

logit_model_1 <- glm("room_type ~ log_number_of_reviews",
                     data = train_set, family="binomial")
summary(logit_model_1)

logit_model_2 <- glm(
  "room_type ~ availability_365 + log_number_of_reviews",
  data = train_set, family = "binomial")
summary(logit_model_2)


logit_model_3 <- glm(
  "room_type ~ availability_365 + log_number_of_reviews + log_price",
  data = train_set, family = "binomial")

summary(logit_model_3)

logit_model_4 <- glm(
  "room_type ~ availability_365 + log_number_of_reviews + log_price +
log_minimum_nights",
  data = train_set, family = "binomial")
summary(logit_model_4)

logit_model_5 <- glm(
  "room_type ~ availability_365 + log_reviews_per_month + log_price +
log_minimum_nights",
  data = train_set, family = "binomial")
summary(logit_model_5)

model_formulas <- combine_predictors(
  dependent = "room_type",
  fixed_effects = c("log_minimum_nights",
                    "log_number_of_reviews",
                    "log_price",
                    "availability_365",
                    "log_reviews_per_month"),
  max_interaction_size = 2,
  max_effect_frequency = 1)
head(model_formulas, 10)

train_set <- fold(train_set, k = 5,
                  num_fold_cols = 5,
                  cat_col = "room_type")

initial_cv_results <- cross_validate(
  train_set,
  models = model_formulas,
  fold_cols = ".folds_1",
  family = "binomial",
  parallel = TRUE)
initial_cv_results <- initial_cv_results[
  order(initial_cv_results$F1, decreasing = TRUE),]
head(initial_cv_results, 10)

# Reconstruct the best 20 models' formulas
reconstructed_formulas <- reconstruct_formulas(
  initial_cv_results,
  topn = 20)

# Create fold_cols
fold_cols <- paste0(".folds_", 1:5)
# Perform repeated cross-validation
repeated_cv_results <- cross_validate(
  train_set,
  models = model_formulas,
  fold_cols = fold_cols,
  family = "binomial",
  parallel = TRUE)
# Order by F1
repeated_cv_results <- repeated_cv_results[
  order(repeated_cv_results$F1, decreasing = TRUE),]
# Inspect the 10 best modelsresults
head(repeated_cv_results)

# Find the Pareto front
front <- psel(repeated_cv_results,
              pref = high("F1") * high("'Balanced Accuracy'"))
# Remove rows with NA in F1 or Balanced Accuracy
front <- front[complete.cases(front[1:2]), ]
# Inspect front
front

# Create ggplot object
# with precision on the x-axis and precision on the y-axis
ggplot(repeated_cv_results, aes(x = F1, y = 'Balanced Accuracy')) +
  # Add the models as points
  geom_point(shape = 1, size = 0.5) +
  # Add the nondominated models as larger points
  geom_point(data = front, size = 3) +
  # Add a line to visualize the pareto front
  geom_step(data = front, direction = "vh") +
  # Add the light theme
  theme_light()

# Reconstruct the formulas for the front models
reconstructed_formulas <- reconstruct_formulas(front)
# Validate the models in the Pareto front
v_results_list <- validate(train_data = train_set,
                           test_data = valid_set,
                           models = reconstructed_formulas,
                           family = "binomial")
# Assign the results and model(s) to variable names
v_results <- v_results_list$Results
v_model <- v_results_list$Models[[1]]
v_results

summary(v_model)

