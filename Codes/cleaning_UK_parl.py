"""
This script: Making British Parliament corpus ready for analysis
"""


# %% Loading Packages

import pandas as pd
import numpy as np
import pyreadr as rd
import os

# %% importing corpus

result = rd.read_r('./Data/dataverse_files/Corp_HouseOfCommons_V2.Rds') # also works for RData
# done! 
# result is a dictionary where keys are the name of objects and the values python
# objects. In the case of Rds there is only one object with None as key
df = result[None]

os.getcwd()
