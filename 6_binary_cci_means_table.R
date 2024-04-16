library(tidyverse)
library(arsenal)

source("data_preparation.R")

cci <- cci %>% 
  select(-session, -datedig) %>%
  mutate(across(where(is.double), remove_outliers)) %>%
  rename(Group = scd_cci)

means_table <- tableby(
  Group ~ HP_tail_lh_hippo2dti_fa +
    HP_tail_rh_hippo2dti_fa +
    HP_tail_lh_hippo2dti_md +
    HP_tail_rh_hippo2dti_md +
    HP_tail_lh_hippo2dti_rd +
    HP_tail_rh_hippo2dti_rd +
    HP_tail_lh_hippo2dti_ad +
    HP_tail_rh_hippo2dti_ad +
    HP_tail_lh_hippo2dki_kfa +
    HP_tail_rh_hippo2dki_kfa +
    HP_tail_lh_hippo2dki_mk +
    HP_tail_rh_hippo2dki_mk +
    HP_tail_lh_hippo2dki_rk +
    HP_tail_rh_hippo2dki_rk +
    HP_tail_lh_hippo2dki_ak +
    HP_tail_rh_hippo2dki_ak +
    HP_body_rh_hippo2dti_fa +
    HP_body_lh_hippo2dti_md +
    HP_body_rh_hippo2dti_md +
    HP_body_lh_hippo2dti_rd +
    HP_body_rh_hippo2dti_rd +
    HP_body_lh_hippo2dti_ad +
    HP_body_rh_hippo2dti_ad +
    HP_body_lh_hippo2dki_kfa +
    HP_body_rh_hippo2dki_kfa +
    HP_body_lh_hippo2dki_mk +
    HP_body_rh_hippo2dki_mk +
    HP_body_lh_hippo2dki_rk +
    HP_body_rh_hippo2dki_rk +
    HP_body_lh_hippo2dki_ak +
    HP_body_rh_hippo2dki_ak +
    HP_head_rh_hippo2dti_fa +
    HP_head_lh_hippo2dti_md +
    HP_head_rh_hippo2dti_md +
    HP_head_lh_hippo2dti_rd +
    HP_head_rh_hippo2dti_rd +
    HP_head_lh_hippo2dti_ad +
    HP_head_rh_hippo2dti_ad +
    HP_head_lh_hippo2dki_kfa +
    HP_head_rh_hippo2dki_kfa +
    HP_head_lh_hippo2dki_mk +
    HP_head_rh_hippo2dki_mk +
    HP_head_lh_hippo2dki_rk +
    HP_head_rh_hippo2dki_rk +
    HP_head_lh_hippo2dki_ak +
    HP_head_rh_hippo2dki_ak,
  data = cci, numeric.test = "wt"
)
summary(means_table, text = TRUE)
write2word(means_table, "means_table.docx")
