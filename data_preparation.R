library(tidyverse)
library(data.table)

remove_outliers <- function(x, na.rm = TRUE) 
{
  ## Find 25% and 75% Quantiles using inbuild function
  quant <- quantile(x, probs=c(.25, .75), na.rm = na.rm)
  
  ## Find Interquantile range and multiply it by 1.5 
  ## to derive factor for range calculation
  H <- 1.5 * IQR(x, na.rm = na.rm)
  
  y <- x
  
  ## fill the outlier elements with NA
  y[x < (quant[1] - H)] <- NA
  y[x > (quant[2] + H)] <- NA
  
  y
}

basedir = "/Volumes/research/lazarm03lab/labspace/AD/ADRC"
clinicaldir = file.path(basedir, "ADRC_data/ClinicalData")
projectdir = file.path(basedir, "hippo_subfields")
fsdir = file.path(projectdir, "t1_processed")

clinical <- readxl::read_excel(file.path(clinicaldir, "allscan_ML20152021_final_withScandates.xlsx"))
#clean up record IDs
clinical$record_id <- gsub("-", "", clinical$record_id)
#convert date field to date type
clinical$ScanTime <- ymd(clinical$ScanTime)
clinical$datedig <- ymd(clinical$datedig)
#select visits closest to scan time, and at least 1 year within scan time
clinical <- clinical %>%
  mutate(time2scan = abs(ScanTime-datedig)) %>%
  filter(time2scan < 365) %>%
  group_by(record_id, ScanTime) %>%
  arrange(time2scan) %>% slice(1)

images <- read_csv(file.path(projectdir, "diff_meso_research_full_dates.csv")) 
#convert subject to character
images$subject <- as.character(images$subject)
#convert session to date type
images$session <- ymd(images$session)

diffstats_files <- list.files(path = fsdir, pattern = "*.tsv", full.names = T)
diffstats_list = list()
for (file in diffstats_files) {
  diffstats <- read_tsv(file) %>% 
    rename_with(~paste0(.,"_", basename(file)), -c("Measure:mean")) %>%
    rename(subject = "Measure:mean")
  colnames(diffstats) <- gsub(".tsv", "", colnames(diffstats))
  diffstats_list <- append(diffstats_list, list(diffstats), 0)
}
diffstats <- reduce(diffstats_list, left_join, by="subject") 
df <- left_join(images, diffstats) %>%
  left_join(., clinical, join_by(subject == record_id, session == ScanTime))

gds <- df %>%
  filter(gds < 3 & cdrglob == 0) %>%
  mutate(scd_gds = if_else(gds == 1, "Control", "SCD"))
# print(table(gds$scd_gds))

# cci <- left_join(images, clinical, join_by(subject == record_id, session == ScanTime))
df$cciround <- round(df$cciaverage)
cci <- df %>%
  # select(subject, session, cciround, datedig) %>%
  filter(cciround < 3 & gds < 3 & cdrglob == 0
         ) %>%
  mutate(scd_cci = if_else(cciround == 1, "Control", "SCD"),
         time2scan = abs(session-datedig)
         ) %>%
  filter(time2scan < 365) %>%
  group_by(subject, session) %>%
  arrange(time2scan) %>% slice(1) %>% ungroup()
print(table(cci$cciround))
