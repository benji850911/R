#####109學年度第二學期R語言#####
####2021/05/07####
rm(list=ls())
install.packages("asbio")
library(asbio)

### 樣本設定 ###
set.seed(12) #設計隨機編號
ball_speed <- sample(50:150,20,replace = TRUE) #指派速度樣本
ball_mean <- mean(ball_speed) #指派平均速度
ball_n <- 20 #指派樣本數
ball_sd <- sd(ball_speed) #指派速度標準差

###
ball_z_test <- one.sample.z(ball_speed,              #放入預檢定資料集
                            null.mu = 100,           #虛無假設
                            xbar = ball_mean,        #平均值
                            sigma = ball_sd,         #標準差
                            alternative = "greater", #檢定方式(右尾)
                            conf = 0.95)             #信心值
ball_z_test

### 圖 ###
sigma <- ball_sd #指派標準差
mu0   <- 100 #虛無假設
alpha <- ball_z_test$test$`P-value` #選取之前計算出來的p-value
xLims <- c(0, 200) #定義X座標軸
crit <- qnorm(1-alpha, mu0, sigma)
crit2 <- qnorm(0.95, mu0, sigma) #算出臨界值
#從crit切出100位置
right <- seq(crit, xLims[2], length.out=100)
#利用常態分配分別以剛剛切出100位置分別計算出Y軸位置
yH0r <- dnorm(right, mu0, sigma) 
#利用算出來的平均值與標準差，畫出常態分配
curve(dnorm(x, mu0, sigma), 
      xlim=xLims, lwd=2, col="red", xlab="x", ylab="density", 
      main="Normal distribution", ylim=c(0, 0.018), xaxs="i")
#以臨界值向右塗上陰影
polygon(c(right, rev(right)),
        c(yH0r, numeric(length(right))), border=NA,
        col=rgb(1, 0.3, 0.3, 0.6))
#剛剛上色的部分為計算出來的p-value值
text(crit+5, 0.0015, adj = 0,label="p-value")
#利用藍色線標記出計算出來的p-value值對應的值
abline(v=crit, lty=1, lwd=3, col="blue") 
#標記此線段為計算出來的p-value值對應的值
text(crit+1, 0.010, adj=0, label="←Z0")
#利用紅色線段標記95%信心對應X軸的臨界值
abline(v=crit2, lty=1, lwd=3, col="red")
#標記此線段為95%信心對應X軸的臨界值
text(crit2+1, 0.015,  adj=0, label="←alpha=0.05")

### 檢定力 ###
mu1 <- 130 #假設樣本平均數130為母體平均數
pow <- pnorm(crit, mu1, sigma) #檢定力(power)
beta <- 1-pow #反之用1相減可算出所求beta
#以臨界值到X軸原點切出100位置
left <- seq(xLims[1],
             crit, length.out=100)
#利用常態分配分別以剛剛切出100位子分別計算出Y軸位置
yH1l <- dnorm(left, mu1, sigma)
#利用算出來的平均值與標準差，畫出常態分配
curve(dnorm(x, mu0, sigma), 
      xlim=xLims, lwd=2, col="red", xlab="x", ylab="density", 
      main="Normal distribution", ylim=c(0, 0.018), xaxs="i")
#利用新的平均值與標準差，畫出常態分配
curve(dnorm(x, mu1, sigma), 
      lwd=2, col="blue", add=TRUE)
#以臨界值向右塗上陰影
polygon(c(right, rev(right)),
        c(yH0r,numeric(length(right))), border=NA,     
        col=rgb(1, 0.3, 0.3, 0.6))
#以臨界值向左塗上陰影
polygon(c(left,  rev(left)), 
        c(yH1l, numeric(length(left))),  border=NA,
        col=rgb(0.3, 0.3, 1, 0.6))
#標記出beta
text(crit-12, 0.004, 
     expression(beta),  cex=1.2)
#標記出alpha
text(crit+5,  0.0015,
     expression(alpha), cex=1.2)







set.seed(12)
minutes <- rnorm(80, 1.3229, 0.036)
minutes_mean <- 1.3229
minutes_n <- 80
minutes_sd <- 0.0396
