# Titanic Survival Prediction (Decision Tree Model)

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white) 
![Machine Learning](https://img.shields.io/badge/-Machine%20Learning-01D277?style=for-the-badge)

A decision tree classifier predicting survival outcomes from the Titanic dataset.

## Project Structure

## 🚀 Quick Start

1. **Install Dependencies**:
   ```R
   install.packages(c("rpart", "rpart.plot", "caTools")) 
   ```
source("train.R")  # Creates tree_model.RData
source("predict.R") 
# Output: Survival probabilities for new passengers

# Split data 70/30 train/test
sample <- sample.split(df$Survived, SplitRatio = 0.70)
train <- subset(df, sample == TRUE)
test <- subset(df, sample == FALSE)

# Build decision tree
tree <- rpart(Survived ~., data = train, method = "class")
save(tree, file = "tree_model.RData")

new_data <- data.frame(
  PassengerId = c(980, 981),
  Pclass = c(3, 4),
  Age = c(21, 29),
  # ... other features
)
predict(tree, new_data, type = "prob")

pred <- predict(tree, test, type = "class")
confusionMatrix(pred, test$Survived)