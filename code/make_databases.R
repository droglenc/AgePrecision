here::here()
## Initiate the data.frames
sum <- tests <- data.frame()
## Cycle through results and append to the data.frames
for (i in list.files("data/results_precision","rds",full.names=TRUE)) {
  tmp <- readRDS(i)
  sum <- rbind(sum,tmp$sum)
  tests <- rbind(tests,tmp$tests)
}
## What do they look like.
sum
tests


