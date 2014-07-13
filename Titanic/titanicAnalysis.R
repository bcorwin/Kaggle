#Get needed libraries
require(ggplot2)
require(Amelia)

#Read in the training data
setwd('C:\\Users\\bcorwin\\Kaggle\\Titanic')
train <- read.csv('.\\Raw Data\\train.csv')
attach(train)
train$Survived <- as.factor(Survived)
missmap(train, main="Titanic Training Data - Missings Map",
        col=c("yellow", "black"), legend=FALSE)

#Look at each variable
prop.table(table(Survived,Pclass),2) ##Biggest different is in Upper/Lower class
prop.table(table(Survived,Sex),2) ##Big female/male split
ggplot(train, aes(Age, colour = Survived)) + geom_density() ##Bump at around 10 years, split here for young/old
prop.table(table(Survived,SibSp),2) ##No siblings, biggest division, less occurance of many siblings
prop.table(table(Survived,Parch),2) ##No parch biggest division
##Ticket
ggplot(train, aes(Fare, colour = Survived)) + geom_density()
prop.table(table(Survived,Embarked),2)
)

#Build new vars
train$econClass <- ifelse(Pclass == 1, "upper", ifelse(Pclass == 2, "middle", "lower"))
train$ageGrp <- ifelse(Age <= 10, "young", "old")
train$onlyCld <- ifelse(SibSp == 0, "only child", "not only child")
train$onlyParch <- ifelse(Parch == 0, "only parch", "not only parch")
train$alone <- ifelse(SibSp == 0 & Parch ==0, "alone", "not alone")