library(caTools)
library(data.tree)
install.packages('data.tree')
library(data.tree)
install.packages('ElemStatLearn')
library(rpart.plot)
library(ElemStatLearn)
library(dplyr)

df <- read.csv('C:/Users/Godwin/Downloads/titanic.csv')

colnames(df)

df <- select(df, Survived, PassengerId, Pclass, Sex, Age, Parch, Embarked)
colnames(df)

sum(is.na(df))
colSums(is.na(df))

df$Age[is.na(df$Age)] <- mean(df$Age, na.rm = TRUE)

colSums(is.na(df))
head(df)

#change the categorical values to numeric

df$Gender <- ifelse(df$Sex == "male", 0, 1)

df$Embarked <- as.numeric(factor(df$Embarked))

library(DT)
datatable(df)

df$Sex <- NULL

head(df)

#identifying the significance of each variable
model1 <- lm(Survived ~ ., data=df)

rpart.plot(tree)

printcp(tree)
summary(model1)

df$PassengerId <- NULL

colnames(df)

#training and testing dataset

sample <- sample.split(df$Survived, SplitRatio = 0.70)

train <- subset(df, sample == TRUE)
test <- subset(df, sample == FALSE)

#decision tree model

tree <- rpart(Survived ~., data = train, method = "class")

save(tree, file = "tree_model.RData")

newTitanData <- data.frame(
  PassengerId = c(980, 981), 
  Pclass = c(3, 4),
  Age = c(21, 29),
  Parch = c(2, 0),
  Embarked = c(3,1),
  Gender = c(0, 1)
)
rpart.plot(tree, main='Tree model for titanic survival prediction')

predict_status <- predict(tree, newTitanData, method='prob')

print(predict_status)
summary(tree)

#predictions

tree.Survived.predicted <- predict(tree, test, type='class')

#tree.Survived.predicted <- predict(tree, test, type = 'class')
tree.Survived.predicted <- factor(tree.Survived.predicted)

test$Survived <- factor(test$Survived)
#confusion matrix

confusionMatrix(tree.Survived.predicted, test$Survived)


#creating a factor data structure in R
music_genre <- c('Rock', 'Pop', 'Jazz', 'Classic', 'Pop', 'Jazz', 'Classic', 'Pop', 'Classic', 'Rock', 'Rock', 'Jazz')

music_genre

music_genre <- data.frame(music_genre)

music_genre <- as.numeric(factor(music_genre))
music_genre

#levels(music_genre)

#plotting tree model

prp(tree, title(main='Decision tree classifier'))


#Data from postgreSQL

connect <- dbConnect(
  RPostgres::Postgres(),
  host = 'localhost',
  password = 'Gray',
  dbname = 'machine_learning',
  port = 5432,
  user = 'postgres'
)
query <- 'SELECT * FROM decision_tree'

data <- dbGetQuery(connect, query)

datatable(data)

summary(data)

#conversion of categorical values to numeric features

data$Go <- ifelse(data$go == 'NO', 0, 1)

data$nationality <- as.numeric(factor(data$nationality))

data <- select(data, Go, age, experience, rank, Nationality)

#build a decision tree model

treeModel <- rpart(Go ~ ., data=data, method='class')

summary(treeModel)

#train and test data

split <- sample.split(data, SplitRatio = 0.70)

trainData <- subset(data, split== T)
testData <- subset(data, split == F)

treeModel <- rpart(Go ~., data = trainData, method='class')

#plot model Library(rpart.plot)
prp(treeModel)

#confusion matrix 

tree.predicted <- predict(treeModel, testData, type='class')

tree.predicted <- factor(tree.predicted)

testData$Go <- factor(testData$Go)

confusionMatrix(tree.predicted, testData$Go)


data(iris)
summary(iris)

iris$species <- as.numeric(factor(iris$Species))

iris <- select(iris, species, Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)

colSums(is.na(iris))

splitting <- sample.split(iris, SplitRatio = 0.70)

trainIris <- subset(iris, splitting == TRUE)
testIris <- subset(iris, splitting == FALSE)

irisModel <- rpart(species ~., data = trainIris, method = 'class')
#method='class' <- meaning it's a classification problem
#method='anova' <- meaning it's a regression problem

summary(irisModel)

prp(irisModel)

iris.predicted <- predict(irisModel, test, type='class')

printcp(irisModel)

rpart.plot(irisModel, main='Decision tree Model')

New_data <- data.frame(
  Sepal.Length = 6.3,
  Sepal.Width = 4.5,
  Petal.Length = 1.1,
  Petal.Width = 0.1
)

predicted_species <- predict(irisModel, New_data, method='prob')
print(predicted_species)
# Load libraries
library(rpart)
library(rpart.plot) # For plotting the tree
datatable(iris)

# Load a sample dataset, e.g., iris
data(iris)

# Train a decision tree model
tree_model <- rpart(Species ~ ., data = iris, method = "class")

# Plot the decision tree
rpart.plot(tree_model)


