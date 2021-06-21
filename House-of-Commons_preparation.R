library(tidyverse)

path <- "C:/Users/bantel/OneDrive/SICSS_affect_NLP/Data/dataverse_files/"
file_in <- paste0(path, "Corp_HouseOfCommons_V2.rds")

file_out <- paste0(path, "Corp_HouseOfCommons_V2.csv")
file_out1 <- paste0(path, "Corp_HouseOfCommons_V2_1.csv")
file_out2 <- paste0(path, "Corp_HouseOfCommons_V2_2.csv")


HoC <- readr::read_rds(file_in) %>% tibble()

# HoC %>% head() %>% .$text

# 1)
HoC %>% head(1500000) %>% write_csv(file_out1)
HoC[1500000:nrow(HoC),] %>% write_csv(file_out2)
HoC %>% write_csv(file_out)