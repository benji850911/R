#####109學年度第二學期R語言#####
####2021/03/19####
##運算與指派運算##
1+1
x <- 2+1
y <-3+4
z <- 4+9

##Removes all items in Environment!##
#rm(list=ls()) #ls當前所有物件
#rm(x)
#rm(y, z)
#rm(x, y, z)
#ls() #顯示當前物件
#objects() #顯示當前物件

####################
##常用函式##
x <- c(4, 9, 16, 25) #建構一個向量
mean(x) #x的平均數
median(x) #x的中位數
range(x)
var(x) #x的變異數
sd(x) #x的標準差
max(x) #x的最大值
min(x) #x的最小值
sqrt(x) #x的開根號
abs(x) #絕對值
y <- 0.12345678
round(y, 2) #對y做四捨五入到第2位
log(x) #取對數，底為e
log(x, 10) #底為10
exp(x) #指數函數，e^x
choose(5, 2) #二項式係數
7%/%3 #商
7%%3 #餘數


####################
##資料模式(mode)##
a<-3; class(a) #numeric(實數)
b<-3+2i; class(b) #complex(複數)
c<-"hellow!"; class(c) #character(文字)
d<-TRUE; class(d) #logical(邏輯值)
e<-NA; class(e) #missing value(遺失值)
#是不是一個...
x<-c("A", "B", NA, NaN)
is.numeric(x)
is.complex(x)
is.character(x)
is.na(x)
#模式轉換
x <- pi; x
mode(x)
as.numeric(x)
as.integer(x) #整數
as.complex(x)
as.character(x)
####################
##建構向量, 矩陣, data.frame##
#向量
a1 <- c(2, 5, 10) #建構一向量物件
a2 <- seq(from=0, to=1, by=0.2) #由0到1且間隔為0.2的向量
a3 <- seq(from=1, by=10, length=5) #5個由1開始間隔為10..
aaa <- c(1, 2, 3, 4, 5, 6, 7, 8, 90, 1, 2, 345, 123)
length(aaa) #查看個數
a4 <- rep(c(2, 3, 4), 1:3); a4 #這三個數分別重複1, 2, 3次
a5 <- "AB"; rep(a5, times=5); #times可省略
a5 <- "AB"; rep(a5, 5)
a6 <- c("A", "B"); rep(a6, times=5)
a7 <- c("A", "B"); rep(a7, each=5) #依序
a8 <- c("C", "D"); rep(a8, 6)
#矩陣
z <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, byrow=T); z
#byrow=T 根據矩陣列的方向來排序，默認為欄位方向，如下。
z1 <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2); z1
z2 <- matrix(c(1, 2, 3, 4, 5, 6), ncol=2); z2
z3 <- matrix(z1, nrow=3, ncol=2); z3
#z2%*%z3 #不能互乘
z2%*%z1 #方正
#Data.frame
x<-c("男","男","女","女","男","女","男","女","女","男")
y<-c(100, 90, 95, 85, 44, 86, 23, 67, 99, 33)
z<-c(55, 66, 78, 95, 33, 22, 15, 16, 33, 88)
q1 <- data.frame(x, y, z); q1
#cbind()
a12 <- cbind(x, y, z)
class(a12)
class(q1)
x<-c("男","男","男","女","女","男","女","男","女","女")
y<-c(92,80,90,60,72,86,96,68,48,88)
z<-c(56,87,38,78,76,65,89,100,54,92)
k<-c(98,22,67,85,73,36,68,47,38,20)
A<-data.frame(性別=x,數學成績=y); A
B<-data.frame(英文成績=z, 國文成績=k); B
rbind(A,B)
cbind(A,B)
####################
##邏輯值##
#關係比較
x <- seq(from=-1, to=1, by=1); x
x<0 #(x是否<0)
x>0
x==0 #(x是否=0)
x<=0
x>=0
x!=0 #(x是否不等於0)
#邏輯向量操作
x <- seq(from=0, to=5, by=1); x
y <- seq(from=3, to=8, by=1); y
(x>4)
(y>4)
(x>4)&(y>4) #&比較嚴格，兩個true才是true。
(x>4)|(y>4)
!(x>4) 
#&適用於向量式的邏輯判斷，&&適用於單一值的邏輯判斷。|同理。
a13 <- c(10, 20, 30);a13 
a14 <- c(2, 22, 0); a14
a13 > 4 && a14 > 10 
a13 > 4 || a14 > 10
#(運算順序 !>&>|)
x <- 3; y<- -3
(x>2)&(y<2)|!(x+y!=3)
####################
##if, switch, repeat迴圈, for迴圈, while迴圈##
#if
x<-1
if(x==1){x}
#switch{數值, 程式1, 程式2, ..., 程式N}
switch(1, 4, 1+1, "A")
switch(2, 5, 2+2, "B")
switch(3, 6, 3+3, "C")
#repeat
x<-0
#repeat{x<-x+1; print(x)} #無窮
repeat{
  if(x==10){break}
  x<-x+1; print(x)} #break停止
#if搭配for迴圈
x<-c("男","男","女","女","男","女","男","女","女","男")
y<-c(100, 90, 95, 85, 44, 86, 23, 67, 99, 33)
z<-c(55, 66, 78, 95, 33, 22, 15, 16, 33, 88)
q1 <- data.frame(x, y, z); q1
q2 <- data.frame(性別=x, 數學=y, 國文=z); q2
#男生全考0分
for(i in 1:10)
{if(q2[i, 1]=="男"){
  q2[i, 3] <- 0}}


#女生考99
for(i in 1:10){
if(q2[i, 1]=="男"){
  q2[i, 3] <- 0}
  else{q2[i, 3] <- 99}}
  

#while迴圈
x <- 0
while(x<=10){print(x); x <- x+1}
while(x<=10){x <- x+1; print(x)}
####################
#其他
rnorm(100) #100個呈常態分配的資料
runif(5) #五個介於0與1的均勻分佈隨機變數
runif(5,2,10) #產生五個介於2到10的均勻分佈隨機變數 
rnorm(100, 40, 10) #100個平均40標準差為10
sample(6,3) #sample(n,m)產生三個介於 1 到 6 的隨機整數
sample(6,8,replace=TRUE) #8個介於1到6的數字
#sample(6,8)#錯誤，默認為不放回
####################
#套件
#library(AER)
####################
rm(list=ls()) #Removes all items in Environment!
##基本敘述統計##
# 次數計算
## set environment & import data
setwd("C:/Users/User/Desktop/R/R-project/R Statistics/data")
tw <- read.table("tw_marriage.txt") #會有狀況
tw <- read.table("tw_marriage.txt", header = T) #first row -> colname
summary(tw)
# 彙整分組表格數據
xtabs(widowed ~ area, data=tw) #widowed(喪偶)依照區域分類計算人數

xtabs(married ~ area + gender, data=tw) #已婚者依照區域與性別分組
t(xtabs(married ~ area + gender, data=tw)) #轉置
# 也可以如下
tw.xtabs <- xtabs(married ~ gender + area, data=tw) #更簡潔

margin.table(tw.xtabs,margin=1)	#橫列邊際總和
margin.table(tw.xtabs,margin=2)	#直行邊際總和
# 也可以
rowSums(xtabs(married ~ gender + area, data = tw)) #橫列總和
colMeans(xtabs(married ~ gender + area, data = tw))
colSums(xtabs(married ~ gender + area, data = tw))   
#############################
# tapply 可以計算各格的平均數等資料
# 各區未婚人士依照性別與區域分組的平均(因為一區域有包含很多縣市)
tapply(tw$unmarried, list(tw$gender,tw$area), FUN = mean)
# 以下則是最大值
tapply(tw$unmarried, list(tw$gender,tw$area),FUN = max)

# aggregate可以達成類似tapply的效果，但輸出結果為每一組一列
#可以用來做後續處理
aggregate(tw$unmarried, by=list(tw$gender, tw$area), FUN=mean)

# prop.table 比例
# round 去小數後進位 prop.table 比例
round(prop.table(xtabs(married ~ gender + area,data=tw)), 2) #小數點後2位 

round(prop.table(xtabs(married ~ gender + area, data=tw),
                 margin=1),2)	#列總和100%

round(prop.table(xtabs(married ~ gender + area, data=tw),
                 margin=2),2) #行總和100%

xtabs(married ~ city + gender , data=tw) #依縣市、性別分組
aggregate(tw$married, by=list(tw$city, tw$gender), FUN=mean) #無意義
###########################################################
cards <- c("金卡", "白金卡", "普通卡", "普通卡", "普通卡", 
           "金卡", "普通卡", "普通卡", "普通卡", "普通卡", 
           "普通卡", "金卡", "普通卡", "白金卡", "金卡", 
           "普通卡", "普通卡", "普通卡", "白金卡", "普通卡")

area <- c("南", "北", "南", "南", "北", 
          "南", "南", "南", "南", "南",
          "北", "南", "南", "南", "南", 
          "北", "北", "北", "北", "南")

gender <- c("女", "女", "女", "女", "女", 
            "男", "女", "男", "男", "男", 
            "男", "女", "女", "男", "女", 
            "女", "男", "男", "男", "男")
x1 <- data.frame(cards, area, gender); x1
#想知道各卡片種類人數
#xtabs(cards~area, data=x1) #錯誤，因為都是文字串
tabulate(factor(x1$cards, levels = c("普通卡", 
                                     "金卡", "白金卡")))
table(cards)
table(cards, dnn = "會員名稱")

x2 <- table(cards, gender); x2
x3 <- table(cards, gender, dnn = c("會員分類", "性別")); x3


####練習題####求到小點第二位
##1. 計算會員分類與性別row, col的邊際總和？
margin.table(x2, margin=1)
margin.table(x2, margin=2)
##2. 普通卡的會員佔全體會員多少比例？
prop.table(x2)
##3. 白金卡的會員中男女各佔多少比例 ？
prop.table(x2, margin = 1)
##4. 有多少比例的女生持有金卡？
prop.table(x2)





