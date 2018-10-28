source()
fn <- googledrive::as_id("https://docs.google.com/spreadsheets/d/1RY6DQyi-zCfg_BQ2l_cZRZC_fA6PI3zutFIMIvJfbw8/edit?ts=5bac4a12#gid=0")
googledrive::drive_download(file=fn,path="data/Literature_Review",overwrite=TRUE)

study <- readxl::read_excel("data/Literature_Review.xlsx",
                            sheet="Study",na=c("","NA")) %>%
  select(-notes,-minedrefs)
str(study)
res <- readxl::read_excel("data/Literature_Review.xlsx",
                          sheet="Results",na=c("","NA")) %>%
  select(-notes,-tech)
str(res)
