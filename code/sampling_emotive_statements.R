#################################################################################################㐂
##### Script: Sampling emotive statements                                                        ##
#################################################################################################㐂


library(tidyverse)
library(data.table)
library(writexl)

df <- read_csv("./data/UK-HoC/UK_parl_combined.csv")


#################################################################################################㐂
##### Filtering emotive statements based on sentiment                                            ##
#################################################################################################㐂



df$numwords = str_count(df$sentences, '\\w+')

hist(df$numwords)
summary(df$numwords)

sum(df$numwords>50)

# Filtering out the 10% longest statements and all statements containing less than five words.
df <- df %>% filter(numwords > 4 & numwords <= 40)

hist(df$txtblob_subjectivity)
hist(df$txtblob_polarity)
hist(df$flair)
hist(df$vader_compound)
hist(df$vader_neu)
hist(df$vader_neg)




set.seed(123)

# Using textblob to separate statements - does not work too well
df %>% filter(txtblob_subjectivity < 0.05) %>% sample_n(10) %>% select(sentences)
df %>% filter(txtblob_subjectivity > 0.95) %>% sample_n(10) %>% select(sentences)

df %>% filter(abs(txtblob_polarity) < 0.05) %>% sample_n(10) %>% select(sentences)
df %>% filter(abs(txtblob_polarity)  > 0.95) %>% sample_n(10) %>% select(sentences)

# Turning to flair - also no good really
df %>% filter(abs(flair) < 0.6) %>% sample_n(10) %>% select(sentences)
df %>% filter(abs(flair)  > 0.95) %>% sample_n(10) %>% select(sentences)

# Finally looking at vader - looks like vader compound works best for our purposes
df %>% filter(vader_neu < 0.5) %>% sample_n(10) %>% select(sentences)
df %>% filter(vader_neu  > 0.95) %>% sample_n(10) %>% select(sentences)

df %>% filter(vader_neg > 0.3 | vader_pos > 0.3) %>% sample_n(10) %>% select(sentences)
df %>% filter(vader_neg < 0.05 & vader_pos < 0.05) %>% select(sentences)


df %>% filter(abs(vader_compound) < 0.05) %>% sample_n(10) %>% select(sentences)
df %>% filter(abs(vader_compound) > 0.75) %>% sample_n(10) %>% select(sentences)


fitered_df_neg <- df %>% filter(vader_compound < -0.75)
fitered_df_pos <- df %>% filter(vader_compound > 0.75)

fitered_df_neutr <- df %>% filter(abs(vader_compound) < 0.1) 

#################################################################################################㐂
##### Doing the sampling                                                                         ##
#################################################################################################㐂

# splitting up 
pos_sample     <- fitered_df %>% filter(date < "2019-01-31", party %in% c("Con", "Lab")) %>% group_by(party) %>% sample_n(45)
neg_sample     <- fitered_df %>% filter(date < "2019-01-31", party %in% c("Con", "Lab")) %>% group_by(party) %>% sample_n(45)
neutr_sample   <- fitered_df %>% filter(date < "2019-01-31", party %in% c("Con", "Lab")) %>% group_by(party) %>% sample_n(10)



final_sample <-  bind_rows(pos_sample, neg_sample, neutr_sample)  %>% ungroup()
final_sample <- final_sample[sample(nrow(final_sample)),] %>% select(sentences)
 
write_xlsx(final_sample,"./data/sample_phrases_V2_raw.xlsx")

