#####109學年度第二學期R語言#####
setwd("C:/Users/User/Desktop/R/R-project/R Statistics/data")
#### 2021/05/26 ####
rm(list=ls())
install.packages("kableExtra")
install.packages("broom")
install.packages("tidy")
library(kableExtra)
library(knitr) 
library(broom)
library(tidyverse)
library(jtools)
options(scipen=999)
#### ANOVA 分析 ####
### 單因子 ANOVA 分析 ### 
Y1 <- c(575,542,530,539,570)
Y2 <- c(565,593,590,579,610)
Y3 <- c(600,651,610,637,629)
Y4 <- c(725,700,715,685,710)
Y <- c(Y1,Y2,Y3,Y4); Y
# Treatment 
# 若為數值只會是 1，文字串會自動分辨
A <- as.factor(rep(c("160w","180w","200w","220w"),each=5)); A
#
data.frame(Y, A)
a1 <- aov(Y ~ A)
summary(a1)
tab1 <- tidy(a1) #製成表格
model.tables(a1,type="effects") #各類別對Y的估計量
model.tables(a1,type="means") #各類別時的平均估計值

### 隨機集區 & 二因子 ANOVA 分析 ### 無交互作用
#way 1#
Blocks <- rep(paste("B",1:6,sep=""), each = 4)
Extrusion <- rep(c(8500,8700,8900,9100), times = 6)
way1 <- data.frame(Blocks, Extrusion); way1

#way 2#
way2 <- expand.grid(Blocks=paste("B",1:6,sep=""),
                     Extrusion=c(8500,8700,8900,9100))
way2

### 
# 壓力
Y1 <- c(90.3,89.2,98.2,93.9,87.4,97.9)
Y2 <- c(92.5,89.5,90.6,94.7,87.0,95.8)
Y3 <- c(85.5,89.5,85.6,87.4,78.9,90.7)
Y4 <- c(82.5,89.5,85.6,87.4,78.9,90.7)
Y <- c(Y1,Y2,Y3,Y4); Y
way2$Extrusion <- as.factor(way2$Extrusion)
way2$Blocks <- as.factor(way2$Blocks) #可加可不加
way2$Y <- Y

# 基本資訊
tapply(way2$Y,list(way2$Extrusion),mean)
tapply(way2$Y,list(way2$Extrusion),sd)
tapply(way2$Y,list(way2$Blocks),mean)
tapply(way2$Y,list(way2$Blocks),sd)
#
a2 <- aov(Y ~ Extrusion + Blocks, data = way2)
summary(a2)
tab2 <- tidy(a2) #製成表格

#### 有交互作用 ####
M <- read.table("twoway-2.txt")
M <- as.matrix(M)

# way 1 #
N <- 6*12
Y <- numeric(N) 
FactorA <- character(N)
FactorB <- character(N)

k <- 1
for (i in 1:12)
{
  i2 <- ceiling(i/2) #factor B 每兩列 (row) 為一類
  for (j in 1:6)
  {
    Y[k] <- M[i,j]
    FactorA[k] <- switch(j,"A1","A2","A3","A4","A5","A6")
    FactorB[k] <- switch(i2,"B1","B2","B3","B4","B5","B6")
    k <- k+1
  }
}

data <- data.frame(Y, FactorA, FactorB)
data

# way 2 #
y <- as.vector(t(M))
y1 <- c(M)
#
FA <- rep(c("A1","A2","A3","A4","A5","A6"), times = 12)
FB <- rep(c("B1","B2","B3","B4","B5","B6"), each = 12)

D <- data.frame(y, FA, FB)

# 基本資訊
tapply(D$y,list(D$FA),mean)
tapply(D$y,list(D$FA),sd)
tapply(D$y,list(D$FB),mean)
tapply(D$y,list(D$FB),sd)

# interaction.plot
interaction.plot(FA,FB,y,col=1:6)

#
aov.model <- aov(y ~ FA*FB, data = D)
summary(aov.model)
tab3 <- tidy(aov.model)

### 課堂練習 ###
r1 <- c(18, 17, 21, 22)
r2 <- c(15, 14, 20, 19)
r3 <- c(21, 20, 22, 25)
r4 <- c(16, 23, 23, 22)
r5 <- c(19, 19, 24, 20)
r6 <- c(13, 25, 22, 24)
r7 <- c(21, 21, 26, 22)
r8 <- c(19, 23, 24, 24)
r9 <- c(14, 25, 28, 20)
r10 <- c(23, 22, 29, 25)
r11 <- c(21, 24, 30, 20)
r12 <- c(25, 20, 28, 26)
r13 <- c(25, 24, 28, 28)
r14 <- c(24, 25, 29, 30)
r15 <- c(26, 23, 27, 26)
Y6 <- c(r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, 
        r11, r12, r13, r14, r15)
length(Y6)
#
FA <- rep(c("US 6","West End","Hickory St","Route 59"), times = 15)
FB <- rep(c("Deans","Snaverly","Ormson","Zollaco","Filbeck"), each = 12)

D2 <- data.frame(Y6, FA, FB)

# 基本資訊
tapply(D2$Y6,list(D2$FA),mean)
tapply(D2$Y6,list(D2$FA),sd)
tapply(D2$Y6,list(D2$FB),mean)
tapply(D2$Y6,list(D2$FB),sd)

# interaction.plot
interaction.plot(FA,FB,Y6,col=1:4)
#
aov.model <- aov(Y6 ~ FA*FB, data = D2)
summary(aov.model)
tab3 <- tidy(aov.model)


