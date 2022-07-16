library(tidyverse)

# use "Corp_HouseOfCommons_V2.rds" from here:
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/L4OAKN

file_in <- paste0(path, "Corp_HouseOfCommons_V2.rds")

file_out <- paste0(path, "Corp_HouseOfCommons_V2.csv")

HoC <- readr::read_rds(file_in) %>% tibble()

# HoC %>% head() %>% .$text

# Take first 150k rows and export to CSV
HoC %>% head(1500000) %>% write_csv(file_out1)
HoC %>% write_csv(file_out)