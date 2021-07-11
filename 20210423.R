#####109學年度第二學期R語言#####
####2021/04/23####
rm(list=ls()) #Removes all items in Environment!
## set environment & import data
setwd("C:/Users/User/Desktop/R/R-project/R Statistics/data")
##
library(asbio)
babies <- read.table("babies.txt", header = T)
b1 <- na.omit(babies) #去除NA值
bwt <- b1$bwt
### 母體平均數 ###(alternative="two.sided","less","greater")
## 母體變異數已知(常態母體或大樣本)：Z
## 假設母體標準差已知(18.236)，a = 0.05(預設)，雙尾檢定
one.sample.z(bwt, null.mu = 120, sigma = 18.236, 
             alternative = "two.sided") #故不拒絕 H0
# 區間估計
width <- qnorm(0.975)*(18.236/sqrt(length(bwt))) #qnorm(常態分配機率)
mean(bwt) + c(-width, width)

## 母體變異數未知(常態母體)：t
# t.test(x, mu, alternative, conf.level)
t.test(bwt, mu = 120, alternative = "two.sided")
t.test(bwt, mu = 120, alternative = "two.sided", 
       conf.level = 0.92) #其他信賴水準
####################
### 母體比例p ###
## prop.test(x, n, p, alt, conf)
prop.test(x = 46, n = 150, p = 1/3, alternative = "greater")
## 講義Ch9, p.22, 範例14
prop.test(x = 275, n = 500, p = 0.5, alternative = "two.sided")
####################
### 兩母體比例差 ###
#方法1
p1 <- 128/200
p2 <- 86/150
c(p1, p2)
center <- p1 - p2
width <- qnorm(0.975)*sqrt(p1*(1 - p1)/200 + p2*(1 - p2)/150 )
c(lower <- center - width, upper <- center + width)
#方法2
graduated = c(214, 219) #x
citizen  = c(1586, 1619) #n
prop.test(graduated, citizen) #不拒絕H0

### 兩母體平均數差：樣本獨立###
##假設兩母體變異數已知 25, 36, 大樣本
x <- c(62, 57, 70, 55, 55, 64, 55, 67, 60, 64, 51, 55, 
       57, 68, 61, 61, 61, 64, 57, 56, 67, 59, 60, 61, 
       71, 65, 63, 63, 58, 58)
y <- c(61, 62, 68, 54, 60, 69, 53, 60, 61, 62, 67, 61, 
       60, 58, 65, 66, 61, 62, 66, 71, 61, 62, 55, 58, 
       66, 60, 58, 60, 63, 48)
center <- mean(x) - mean(y)
width <- qnorm(0.975)*sqrt(25/30 + 36/30)
c(lower <- center - width, upper <- center + width)
##假設兩母體變異數未知, 大樣本
c(var(x), var(y))
center <- mean(x) - mean(y)
width <- qnorm(0.975)*sqrt(var(x)/30 + var(y)/30)
c(lower <- center - width, upper <- center + width)

##小樣本, 假設母體為常態分配, 兩母體變異數相等
#方法1
x <- c(61, 65, 57, 56, 64, 64, 57, 65, 55, 67, 67, 60, 
       56, 58, 55, 60, 62)
y <- c(56, 66, 57, 56, 63, 61, 66, 61, 62, 55, 55, 62, 
       55, 70, 51)
s2.A <- var(x)
s2.B <- var(y)
s2.p <- ((17 - 1)*s2.A + (15 - 1)*s2.B)/(17 + 15 - 2)
center <- mean(x) - mean(y)
width <- qt(0.975, 17 + 15-2)*sqrt(s2.p*(1/17 + 1/15))
c(lower <- center - width, upper <- center + width)
#方法2
t.test(x, y, var.equal = TRUE, alternative = "two.sided", mu=0.0, conf.level = 0.95 )
##小樣本, 假設母體為常態分配, 兩母體變異數不相等
sn1 <- var(x)/17
sn2 <- var(y)/15
v <- trunc((sn1 + sn2)^2/(sn1^2/(17 - 1) + sn2^2/(15 - 1)))
v
center <- mean(x) - mean(y)
width <- qt(0.975, 26)*sqrt(var(x)/17 + var(y)/15)
c(lower <- center - width, upper <- center + width)

### 兩母體平均數差：相依樣本 ###
##大樣本
x <- c(129, 314, 294, 261, 188, 222, 230, 165, 117, 
       248, 267, 286, 216, 292, 175, 120, 269, 195, 
       248, 174, 245, 197, 100, 121, 168, 239, 207, 
       180, 160, 288)
y <- c(380, 402, 374, 306, 374, 423, 344, 363, 371, 
       350, 294, 318, 338, 333, 349, 350, 333, 339, 
       359, 338, 347, 340, 268, 346, 425, 362, 281, 
       353, 313, 346)
D <- x - y
center <- mean(D)
width <- qnorm(0.975)*sd(D)/sqrt(30)
c(lower <- center - width, upper <- center + width)

##小樣本
x <- c(8, 5, 7, 12, 7, 5, 7, 6, 7, 8, 9, 
       6, 8, 9, 8, 5, 6, 5, 5)
y <- c(11, 4, 3, 5, 7, 4, 6, 2, 1, 0, 11, 
       5, 6, 7, 8, 6, 3, 2, 2)
D <-	x - y
center <- mean(D)
width <- qt(0.975, 19 - 1)*sd(D)/sqrt(19)
c(lower <- center - width, upper <- center + width)

### 變異數檢定 ###
cancers <- read.table("cancers.txt", header = T)
x1 <- cancers$stomach
x2 <- cancers$bronchus
var.result <- var.test(x1, x2, alternative = "two.sided")
var.result$p.value #不拒絕H0
t.test(x1, x2, alternative = "two.sided", mu = 0.0,
       paired = FALSE, var.equal = TRUE, conf.level = 0.95) #不拒絕H0

##講義Ch10, p.28
Welles <- c(2, 4, 9, 3, 2)
Atkins <- c(3, 7, 5, 8, 4, 3)
t.test(Welles, Atkins, alternative = "two.sided", mu = 0.0,
       paired = FALSE, var.equal = TRUE, conf.level = 0.9)
##講義Ch10, p.30 
Schadek <- c(235, 210, 231, 242, 205, 230, 
             231, 210, 225, 249)
Bowyer <- c(228, 205, 219, 240, 198, 223, 
            227, 215, 222, 245) 
t.test(Schadek, Bowyer, alternative = "two.sided", mu = 0.0,
       paired = TRUE, var.equal = TRUE, conf.level = 0.95)






##練習題##
x1 <- c(85, 93, 72, 71, 96, 88)
x2 <- c(81, 86, 64, 63, 88, 87)
t.test(x1, x2, alternative = "greater", mu = 0.0,
       paired = TRUE, var.equal = TRUE, conf.level = 0.95)

