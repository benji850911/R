#####109學年度第二學期R語言#####
####2021/03/26####
library(asbio)
## set environment & import data
setwd("C:/Users/User/Desktop/R/R-project/R Statistics/data")
babies <- read.table("babies.txt", header = T)

## 單樣本統計推論
b <- babies$bwt
fivenum(b)
summary(b)
sd(b)
# 可以自訂函數一次算出更多敘述統計值
my.desc <- function(b){
  b.desc <- c(length(b), summary(b), var(b), sum(b), 
              sqrt(var(b)), IQR(b))
  names(b.desc) <- c("樣本數", "最小值", "Q1", "中位數", 
                    "平均數", "Q3", "最大值", "變異數", 
                    "總和", "標準差", "IQR")
  return(b.desc)
}
my.desc(b)

# 計算眾數
a <- c(1, 1,1 , 2, 3, 4)
table(a)
table(b)
which(table(b) == max(table(b)))

####################
b1 <- na.omit(babies) #去除NA值
bwt <- b1$bwt

# library(asbio)

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
### 母體比例p的區間估計
## prop.test(x, n, p, alt, conf) 
prop.test(x = 46, n = 150, p = 1/3, alternative = "greater")
## 講義Ch9, p.22, 範例14
prop.test(x = 275, n = 500, p = 0.5, alternative = "two.sided")








