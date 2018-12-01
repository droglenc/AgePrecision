cat("\014"); rm(list=ls())
setwd(here::here())
library(FSA)

### Create data from Figure 3
## Scales
fr <- c( 1, 1,10, 7, 1, 4,20, 7, 2, 2,27,15, 1, 2, 6, 8, 5, 2, 1, 3, 4, 6, 2, 2, 1)
r1 <- c( 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9,10)
r2 <- c( 3, 4, 4, 5, 7, 4, 5, 6, 7, 5, 6, 7, 9, 5, 6, 7, 8, 9, 5, 6, 7, 8, 9, 9,10)
df1 <- data.frame(strux="scales",reader="R1",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab1 <- ageBias(read_2~read_1,data=df1)
plotAB(ab1,what="numbers")

fr <- c(9, 6, 3, 1, 1,10,18, 9, 3, 1, 5, 6,19, 5, 2, 1, 1, 4, 5, 3, 1, 2, 6, 5, 6, 1, 2, 1)
r1 <- c(4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 9,10,11)
r2 <- c(4, 5, 6, 7, 4, 5, 6, 7, 8, 9, 5, 6, 7, 8, 9,10, 5, 6, 7, 8, 9, 6, 7, 8, 9, 8, 8,12)
df2 <- data.frame(strux="scales",reader="R2",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab2 <- ageBias(scales_R2_2~scales_R2_1,data=df2)
plotAB(ab2,what="numbers")

fr <- c(1, 2,11, 1, 4, 7, 5, 1, 5, 9,18, 2, 3, 1,13, 9, 4, 2, 3, 8, 2, 1, 1, 2, 2, 1, 4, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1)
r1 <- c(3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9,10,10,10,11,11,11,11,12,12)
r2 <- c(3, 3, 4, 5, 4, 5, 6, 7, 4, 5, 6, 7, 8, 5, 6, 7, 8, 5, 6, 7, 9,10,11, 6, 7, 8, 9,10, 8, 9,10, 6, 8, 9,11,10,12)
df3 <- data.frame(strux="scales",reader="R3",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab3 <- ageBias(scales_R3_2~scales_R3_1,data=df3)
plotAB(ab3,what="numbers")

## Otoliths
fr <- c(1,16,19,3,2,48,2,19,4,12,11,1,1,3,1,3,3,1)
r1 <- c(3,4,5,5,6,6,7,7,7,8,9,9,10,10,10,11,11,12)
r2 <- c(3,4,5,6,5,6,6,7,8,8,9,10,9,10,11,10,11,11)
df4 <- data.frame(strux="otoliths",reader="R1",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab4 <- ageBias(read_2~read_1,data=df4)
plotAB(ab4,what="numbers")

fr <- c(1,16, 2,22,15,34, 3, 1, 4,20, 3, 1, 8, 1, 1, 6, 2, 1, 1, 5, 1, 1, 1)
r1 <- c(3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9,10,10,10,10,11,11)
r2 <- c(3, 4, 5, 5, 6, 6, 7, 5, 6, 7, 8, 7, 8, 9,10, 9,10, 8, 9,10,12,10,11)
df5 <- data.frame(strux="otoliths",reader="R2",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab5 <- ageBias(read_2~read_1,data=df5)
plotAB(ab5,what="numbers",xlim=c(0,12),ylim=c(0,12))

fr <- c(1,16,22,5,1,45,3,1,18,5,1,2,8,1,6,3,2,3,5,1,1)
r1 <- c(3, 4, 5,5,6,6,6,7,7,7,8,8,8,8,9,9,10,10,10,11,12)
r2 <- c(3, 4, 5,6,5,6,7,6,7,8,6,7,8,9,9,10,9,10,11,11,12)
df6 <- data.frame(strux="otoliths",reader="R3",read_1=rep(r1,fr),read_2=rep(r2,fr))
ab6 <- ageBias(read_2~read_1,data=df6)
plotAB(ab6,what="numbers")

df <- rbind(df1,df2,df3,df4,df5,df6)

write.csv(df,file="data/raw_ageing/robillard_comparison_1996.csv",
          quote=FALSE,row.names=FALSE)
