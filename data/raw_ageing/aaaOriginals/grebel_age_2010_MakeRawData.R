### Create data from plots
fn <- "data/raw_ageing/aaaOriginals/Grebel and Cailliet 2010_Data_Scott.xlsx"

## Data for Reader 1 vs Reader 2
r1r2_freq <- readxl::read_excel(fn,sheet="Read 1 vs. Read 2")
r1r2_raw <- data.frame(read1=rep(r1r2_freq$read1,r1r2_freq$freq),
                       read2=rep(r1r2_freq$read2,r1r2_freq$freq))
FSA::peek(r1r2_raw)
tmp <- FSA::ageBias(read1~read2,data=r1r2_raw)
summary(tmp,what="table")  ## looks OK
write.csv(r1r2_raw,file="data/raw_ageing/grebel_age_2010_r1r2.csv",
          quote=FALSE,row.names=FALSE)


## Data for Reader 1 vs Reader 3
r1r3_freq <- readxl::read_excel(fn,sheet="Read 1 vs. Read 3")
r1r3_raw <- data.frame(read1=rep(r1r3_freq$read1,r1r3_freq$freq),
                       read3=rep(r1r3_freq$read3,r1r3_freq$freq))
FSA::peek(r1r3_raw)
tmp <- FSA::ageBias(read1~read3,data=r1r3_raw)
summary(tmp,what="table")  ## looks OK
write.csv(r1r3_raw,file="data/raw_ageing/grebel_age_2010_r1r3.csv",
          quote=FALSE,row.names=FALSE)


## Data for Reader 2 vs Reader 3
r2r3_freq <- readxl::read_excel(fn,sheet="Read 2 vs. Read 3")
r2r3_raw <- data.frame(read2=rep(r2r3_freq$read2,r2r3_freq$freq),
                       read3=rep(r2r3_freq$read3,r2r3_freq$freq))
FSA::peek(r2r3_raw)
tmp <- FSA::ageBias(read2~read3,data=r2r3_raw)
summary(tmp,what="table")  ## looks OK
write.csv(r2r3_raw,file="data/raw_ageing/grebel_age_2010_r2r3.csv",
          quote=FALSE,row.names=FALSE)
