#####109學年度第二學期R語言#####
rm(list=ls())
setwd("C:/Users/User/Desktop/R/R-project/R Statistics/data")
# library #
library(kableExtra)
library(knitr) 
library(broom)
library(tidyverse)
#### 2021/06/11 #### 迴歸分析
# import data #
dogs <- read.table("dogs.txt")
dogs <- read.table("dogs.txt", header=T)
plot(dogs$computerR,dogs$adoptedR)
#若出現亂碼
#colnames(dogs) <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m")

### b0, b1 ### way1
x <- dogs$computerR
Y <- dogs$adoptedR
# b1
beta1 <- sum((x-mean(x))*(Y-mean(Y)))/sum((x-mean(x))^2)
beta1
# b0
beta0 <- mean(Y)-beta1*mean(x)
beta0

### b0, b1 ### way2
slm.model <- lm(adoptedR ~ computerR, data=dogs)
summary(slm.model)

####################
### 平方和 ### way1
SSTotal <- sum((dogs$adoptedR - mean(dogs$adoptedR))^2)
SSR <- 0.1963*SSTotal #R-squared 有經過四捨五入
SSE <- SSTotal - SSR
# 以下方法較精確
SSE <- deviance(slm.model) 
SSR <- SSTotal - SSE

### 平方和 ### way2
anova(slm.model)

####################
### 區間估計 ### way 1 
qt(0.975,21)	
c(-2.8601 - 2.079614*9.4447, -2.8601 + 2.079614*9.4447)
c(0.2576 - 2.079614*0.1137,0.2576 + 2.079614*0.1137)

## 區間估計 預設a=0.05 ## way 2 
confint(slm.model)
confint(slm.model, level=0.95)
####################
## 其他 ##
names(slm.model)
View(slm.model$coef)

# 取代 tidy #
tab1 <- tidy(slm.model)
#
ss <- summary(slm.model)
View(ss$coefficients)

### 複迴歸 ###
model2 <- lm(adoptedR ~ computerR + crimeR + captured + killedR, 
             data=dogs)
summary(model2)


### 練習題：講義 p.19 (5) ###
x <- c(3.7, 3.6, 2.8, 5.6, 3.3, 2.2, 3.3, 
       3.1, 3.2, 3.5, 5.2, 4.6, 5.8, 3)
y <- c(5.7, 5.9, 6.7, 9.5, 5.4, 3.5, 6.2, 
       4.7, 6.1, 4.9, 10.7, 7.6, 11.8, 4.1)

d1 <- data.frame(x, y)

xm <- mean(d1$x)
ym <- mean(d1$y)

d1$x_m <- d1$x - xm
d1$y_m <- d1$y - ym
d1$xy_m <- d1$x_m*d1$y_m
d1$x_m2 <- (d1$x_m)^2

b1 <- sum(d1$xy_m)/sum(d1$x_m2)
b0 <- ym - b1*xm

##########
r <- sum(d1$xy_m)/(13*sd(d1$x)*sd(d1$y)) # way1
r1 <- cor(x, y) # way2
r2 <- cov(x, y)/(sd(x)*sd(y)) # way3

b1 <- r*(sd(d1$y)/sd(d1$x))
b0 <- mean(d1$y) - b1*mean(d1$x)
##########################
x <- c(3.7, 3.6, 2.8, 5.6, 3.3, 2.2, 3.3, 
       3.1, 3.2, 3.5, 5.2, 4.6, 5.8, 3)
y <- c(5.7, 5.9, 6.7, 9.5, 5.4, 3.5, 6.2, 
       4.7, 6.1, 4.9, 10.7, 7.6, 11.8, 4.1)

d1 <- data.frame(x, y)
#
m1 <- lm(y~x, data = d1)
summary(m1)
#
anova(m1)
#
confint(m1)



