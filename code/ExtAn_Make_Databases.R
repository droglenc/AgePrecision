here::here()
## Initiate the data.frames ----
sum <- tests <- data.frame()
## Cycle through results and append to the data.frames
for (i in list.files("data/results_precision","rds",full.names=TRUE)) {
  fn <- gsub(".rds","",basename(i))
  cat("Processing: ",fn,"\n")
  tmp <- readRDS(i)
  tmp$sum <- mutate(tmp$sum,id=fn)
  sum <- rbind(sum,tmp$sum)
  tmp$tests <- mutate(tmp$tests,id=fn)
  tests <- rbind(tests,tmp$tests)
}
## What do they look like ----
sum
tests

tests2 <- tests %>%
  tidyr::pivot_wider(id_cols=c(id,studyID:type),
                   names_from=var,
                   values_from=HetInLM:Slope) %>%
  select(-(studyID:type))

EA <- left_join(sum,tests2,by="id") %>%
  relocate(id)


## Output database ----
#### As an RData object ... maintains variable types, factor order, etc.
save(EA,file="data/ExtAn.RData")
#### As a CSV file ... loses structure ... don't use, just a back-up in case!
write.csv(EA,file="data/ExtAn_BACKUP.csv",row.names=FALSE)
