library(tidyverse)
library(ggpubr)
library(effectsize)
source("data_preparation.R")

cci <- cci %>% 
  select(-session, -datedig) %>%
  mutate(across(where(is.double), remove_outliers)) %>%
  rename(Group = scd_cci)

####### left tail DTI ##########
ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dti_fa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "FA", title =  "Left Posterior Hippocampus", 
       subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dti_md", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dti_ad", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dti_rd", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### left tail DKI ######
ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dki_kfa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dki_mk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dki_ak", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_lh_hippo2dki_rk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "RK", title = "Left Posterior Hippocampus",
    subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_lh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

####### right tail DTI ##########
ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dti_fa",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     # aes(label = paste0("p = ", after_stat(p.format)))
                     ) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dti_md", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dti_ad", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dti_rd", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### Right Tail DKI ######
ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dki_kfa", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "KFA", title =  "Right Posterior Hippocampus", 
       subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dki_mk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dki_ak", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_tail_rh_hippo2dki_rk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_tail_rh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

####### left body DTI ##########
ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dti_fa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dti_md", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dti_ad", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dti_rd", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### left Body DKI ######
ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dki_kfa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "KFA", title =  "Left Medial Hippocampus", 
       subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dki_mk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "MK", title =  "Left Medial Hippocampus", 
       subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dki_ak", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_lh_hippo2dki_rk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_lh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

####### right body DTI ##########
ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dti_fa", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dti_md", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dti_ad", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dti_rd", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### Right Body DKI ######
ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dki_kfa", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dki_mk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dki_ak", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_body_rh_hippo2dki_rk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_body_rh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

###### left head DTI ########
ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dti_fa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dti_md", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dti_ad", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dti_rd", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### Left Head DKI ######
ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dki_kfa", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dki_mk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dki_ak", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_lh_hippo2dki_rk", error.plot = "errorbar",
          add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_lh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

###### right head DTI ########
ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dti_fa", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dti_fa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dti_md", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(y = "MD", title =  "Right Anterior Hippocampus", 
       subtitle = paste0("Effect size (Cohen's D) = ", signif(cohens_d(HP_head_rh_hippo2dti_md ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dti_ad", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dti_ad ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dti_rd", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dti_rd ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

##### Right Head DKI ######
ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dki_kfa", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dki_kfa ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dki_mk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dki_mk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dki_ak", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dki_ak ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))

ggboxplot(cci, x = "Group", y = "HP_head_rh_hippo2dki_rk", error.plot = "errorbar",
            add = "jitter", add.params = list(color = "Group"), legend = "none") +
  stat_compare_means(label.x.npc = "center", hide.ns = T,
                     aes(label = paste0("p = ", after_stat(p.format)))) +
  labs(subtitle = paste0("Effect size (Cohen's D) = ", 
                         signif(cohens_d(HP_head_rh_hippo2dki_rk ~ Group, data=cci),2))) +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))


# -------------------------------------------------------------------------


