#Ivo's file
#%% Imports
import nltk
#import numpy as np
import os
import pandas as pd
import re
#import spacy
import timeit


#%% sentiment analysis

# [tmp] NLTK vader
import nltk
nltk.download('vader_lexicon')
from nltk.sentiment.vader import SentimentIntensityAnalyzer

sid = SentimentIntensityAnalyzer() # instantiate sentiment intensity analyzer

HoC_l_tmp = pd.read_csv("./data/preprocessed/1-House_of_commons_2019ff_preprocessed.csv",
                        index_col=0).rename(columns={"sentence":"sentences"}) # tmp import
# functionally equivalent to HoC_matthias.csv (which is ambiguously named)

sents_series = HoC_l_tmp['sentences'].astype(str).apply(sid.polarity_scores) # extract scores per row (= sentence)
sents_df = pd.DataFrame(sents_series.tolist(), index = HoC_l_tmp.reset_index()['index'].values.tolist()) # unpack dict to data frame
for col in sents_df: HoC_l_tmp["vader_" + col] = sents_df[col] # merge data frames
del sents_series, sents_df

# [tmp] TextBlob
from textblob import TextBlob

sents_series = HoC_l_tmp["sentences"].astype(str).apply(lambda sentence: TextBlob(sentence).sentiment) # extract scores per row (= sentence)
sents_df = pd.DataFrame(sents_series.tolist(), index = HoC_l_tmp.reset_index()['index'].values.tolist())  # unpack dict to data frame
for col in sents_df: HoC_l_tmp["txtblob_" + col] = sents_df[col] # merge data frames

HoC_l_tmp.to_csv("./data/preprocessed/2-House_of_commons_2019ff_vader-textblob.csv")