import spacy
#import numpy as np
import pandas as pd
#import os
import gzip

#os.chdir("./OneDrive/SICSS_affect_NLP")
data_base = "./Data/dataverse_files/Corp_HouseOfCommons_V2"

df = pd.read_csv(data_base + ".csv")
#df1 = pd.read_csv(data_base + "_1.csv")
#df2 = pd.read_csv(data_base + "_2.csv")
