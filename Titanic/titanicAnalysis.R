#Get needed libraries
require(ggplot2)
require(Amelia)
require(Hmisc)
options(digits = 2)

#Read in the training data
setwd('C:\\Users\\bcorwin\\Kaggle\\Titanic')
train <- read.csv('.\\Raw Data\\train.csv',
                  colClasses = c('integer',
                                  'factor',
                                  'factor',
                                  'character',
                                  'factor',
                                  'numeric',
                                  'integer',
                                  'integer',
                                  'character',
                                  'numeric',
                                  'character',
                                  'factor'),
                  na.strings = c("NA", "")
                  )
attach(train)
missmap(train, main="Titanic Training Data - Missings Map",
        col=c("yellow", "black"), legend=FALSE, y.labels = NULL, y.at = NULL)

#Look at each variable
mosaicplot(Pclass ~ Survived, main = "Fate by Traveling Class", color = TRUE)
mosaicplot(Sex ~ Survived, main = "Fate by Sex", color = TRUE)
mosaicplot(SibSp ~ Survived, main = "Fate by Sibling/Spouse Count", color = TRUE)
mosaicplot(Parch ~ Survived, main = "Fate by Parent/Child Count", color = TRUE)
mosaicplot(Embarked ~ Survived, main = "Fate by Embarkment", color = TRUE)
ggplot(train, aes(Age, colour = Survived)) + geom_density()
ggplot(train, aes(Fare, colour = Survived)) + geom_density()

#Imputation
##Age
title.dot.start <- regexpr("\\,[A-Z ]{1,20}\\.", Name, TRUE)
title.comma.end <- title.dot.start + attr(title.dot.start, "match.length")-1
train$Title <- substr(Name, title.dot.start+2, title.comma.end-1)

##Embarkment

#Random Forest
