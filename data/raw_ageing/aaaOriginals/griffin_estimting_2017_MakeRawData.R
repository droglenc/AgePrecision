### Create data from plots
fn <- "data/raw_ageing/aaaOriginals/Griffin et al 2017_Data_Scott.xlsx"

## Data for pectoral fin rays
pfr_freq <- readxl::read_excel(fn,sheet="Pectoral Fin Rays")
pfr_raw <- data.frame(read1=rep(pfr_freq$reader1,pfr_freq$freq),
                      read2=rep(pfr_freq$reader2,pfr_freq$freq))
FSA::peek(pfr_raw)
tmp <- FSA::ageBias(read2~read1,data=pfr_raw)
summary(tmp,what="table")  ## looks OK

## Data for asteriscii
ast_freq <- readxl::read_excel(fn,sheet="Asteriscus")
ast_raw <- data.frame(read1=rep(ast_freq$reader1,ast_freq$freq),
                      read2=rep(ast_freq$reader2,ast_freq$freq))
FSA::peek(ast_raw)
tmp <- FSA::ageBias(read2~read1,data=ast_raw)
summary(tmp,what="table")  ## looks OK

## Data for scales
sc_freq <- readxl::read_excel(fn,sheet="Scales")
sc_raw <- data.frame(read1=rep(sc_freq$reader1,sc_freq$freq),
                     read2=rep(sc_freq$reader2,sc_freq$freq))
FSA::peek(sc_raw)
tmp <- FSA::ageBias(read2~read1,data=sc_raw)
summary(tmp,what="table")  ## looks OK

## Data for lapillus
lap_freq <- readxl::read_excel(fn,sheet="Lapillus")
lap_raw <- data.frame(read1=rep(lap_freq$reader1,lap_freq$freq),
                      read2=rep(lap_freq$reader2,lap_freq$freq))
FSA::peek(lap_raw)
tmp <- FSA::ageBias(read2~read1,data=lap_raw)
summary(tmp,what="table")  ## looks OK

df <- dplyr::bind_rows("Fin Rays"=pfr_raw,"Scales"=sc_raw,
                       "Asteriscus"=ast_raw,"Lapillus"=lap_raw,
                       .id="structure")
head(df)

write.csv(df,file="data/raw_ageing/griffin_estimating_2017.csv",
          quote=FALSE,row.names=FALSE)


