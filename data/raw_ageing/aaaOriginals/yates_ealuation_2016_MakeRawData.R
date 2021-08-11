### Create data from plots
fn <- "data/raw_ageing/aaaOriginals/Yates et al 2016_Data_Scott.xlsx"

## Data for otoliths
oto_freq <- readxl::read_excel(fn,sheet="Otoliths")
oto_raw <- data.frame(read1=rep(oto_freq$reader1,oto_freq$freq),
                      read2=rep(oto_freq$reader2,oto_freq$freq),
                      structure="Otoliths")
FSA::peek(oto_raw)
tmp <- FSA::ageBias(read2~read1,data=oto_raw)
summary(tmp,what="table")  ## looks OK


## Data for scales
sc_freq <- readxl::read_excel(fn,sheet="Scales")
sc_raw <- data.frame(read1=rep(sc_freq$reader1,sc_freq$freq),
                      read2=rep(sc_freq$reader2,sc_freq$freq),
                      structure="Scales")
FSA::peek(sc_raw)
tmp <- FSA::ageBias(read2~read1,data=sc_raw)
summary(tmp,what="table")  ## looks OK


## Data for pectoral fin rays
pfr_freq <- readxl::read_excel(fn,sheet="Pectoral Finrays")
pfr_raw <- data.frame(read1=rep(pfr_freq$reader1,pfr_freq$freq),
                      read2=rep(pfr_freq$reader2,pfr_freq$freq),
                      structure="Finrays")
FSA::peek(pfr_raw)
tmp <- FSA::ageBias(read2~read1,data=pfr_raw)
summary(tmp,what="table")  ## looks OK


## Data for dorsal spines
ds_freq <- readxl::read_excel(fn,sheet="Dorsal Fin Spines")
ds_raw <- data.frame(read1=rep(ds_freq$reader1,ds_freq$freq),
                      read2=rep(ds_freq$reader2,ds_freq$freq),
                      structure="Spines")
FSA::peek(ds_raw)
tmp <- FSA::ageBias(read2~read1,data=ds_raw)
summary(tmp,what="table")  ## looks OK


df <- dplyr::bind_rows(oto_raw,sc_raw,pfr_raw,ds_raw)
FSA::peek(df)

write.csv(df,file="data/raw_ageing/yates_evaluation_2016.csv",
          quote=FALSE,row.names=FALSE)
