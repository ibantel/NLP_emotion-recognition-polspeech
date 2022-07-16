#Ivo's file
#%% Imports
import nltk
#import numpy as np
import os
import pandas as pd
import re
#import spacy
import timeit

#os.chdir("./OneDrive/SICSS_affect_NLP")
data_base = "./Data/dataverse_files/Corp_HouseOfCommons_V2.csv"

#%% Loading and minor preprocessing of data
HoC = pd.read_csv(data_base)
#HoC1 = pd.read_csv(data_base + "_1.csv")
#HoC2 = pd.read_csv(data_base + "_2.csv")

# unique speech ID from date
HoC['speech_id'] = pd.to_numeric(HoC['date'].str.replace('-','')).apply(str) + HoC['speechnumber'].apply(str).apply(lambda x: x.zfill(6))  # introduce unique ID

# clean date
HoC["date"] = pd.to_datetime(HoC["date"])

# filter on date
HoC_2019f = HoC.loc[HoC["date"] > "2018-12-31"]
del data_base, HoC

# [tmp] rename
HoC = HoC_2019f#.head(1000) ## comment out if entire data set is to be used
del HoC_2019f

# drop unneeded columns
HoC = HoC.drop(columns = ['speechnumber', 'party.facts.id', 'chair', 'terms', 'parliament', 'iso3country'])

#%% Clean text column: delete "hon." and "Order"
HoC['text'] = HoC['text'].apply(lambda x: re.sub('\\bhon. ', '', x, re.IGNORECASE)) # remove polite address "hon." (honourable), as this confuses the sentence splitup
HoC['text'] = HoC['text'].apply(lambda x: re.sub('\\bOrder.', '', x)) # note that this is case specific


#%% Explode data set: one line contains one sentence

#import en_core_web_sm

starttime = timeit.default_timer()
# takes ca. 113 sec on 164k rows (2018f)
HoC["sentences"] = HoC["text"].apply(nltk.tokenize.sent_tokenize)

sentences_series = pd.Series(data = HoC["sentences"].apply(pd.Series).reset_index().melt(id_vars="index").dropna()[['index', 'value']].set_index('index')['value'], name = "sentences")
HoC_long = pd.merge(HoC.drop(columns = "sentences"), sentences_series, left_index=True, right_index=True)
#del sentences_series

print("The time difference is :", timeit.default_timer() - starttime)
del starttime

HoC_long = HoC_long.drop(columns = 'text')

# export intermediary result
HoC_long.head(100).to_csv("./Data/UK-HoC/preprocessed/1-House_of_commons_2019ff_preprocessed_head100.csv")
HoC_long.to_csv("./Data/UK-HoC/preprocessed/1-House_of_commons_2019ff_preprocessed.csv")


#%% NLP
# Here, we would apply the NLP pipeline for NER; 
# However, since we will only do that later (in step 3), it is omitted here

#nlp = spacy.load("en_core_web_sm", disable=["tagger", "attribute_ruler", "lemmatizer"])

#HoC_long["sentences"].head(100).apply(nlp)

