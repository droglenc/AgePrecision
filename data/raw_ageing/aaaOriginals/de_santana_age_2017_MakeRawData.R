cat("\014"); rm(list=ls())
setwd(here::here())
library(FSA)

### Create data from Figures 5 & 6
fr <- c(3,2,6,208,9,27,161,5,15,7,2,1,2,9,3,3,3,1)
r1 <- c(1,2,3,3,3,4,4,4,5,5,5,6,6,6,6,7,7,7)
r2 <- c(1,2,2,3,4,3,4,5,4,5,6,4,5,6,7,6,7,8)
df1 <- data.frame(strux="otoliths",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab1 <- ageBias(read_2~read_1,data=df1)
plotAB(ab1,what="numbers")

fr <- c(9,2,17,15,11,161,23,32,34,1,1,2,7,1,3)
r1 <- c(1,1, 2, 2, 3,  3,3,4,4,4,5,5,5,5,6)
r2 <- c(1,2, 2, 3, 2,  3,4,3,4,5,3,4,5,6,6)
df2 <- data.frame(strux="scales",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab2 <- ageBias(read_2~read_1,data=df2)
plotAB(ab2,what="numbers")

df <- rbind(df1,df2)

write.csv(df,file="data/raw_ageing/de_santana_age_2017.csv",
          quote=FALSE,row.names=FALSE)
