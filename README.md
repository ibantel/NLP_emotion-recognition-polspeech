# `NLP_emotion-recognition-polspeech`

This repository contains the project pursued as part of the Summer Institute in Computational Social Sciences (SICSS) Zurich in 2021 (github.com/computational-social-science-zurich/sicss-zurich, )

The project aims to recognize discrete emotions in political speech (speeches in the UK House of commons).

Data: from the *ParlSpeech project* (https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/L4OAKN).

The project contains:
- `code/`
 ⌞ `/00-House-of-Commons_preparation.R` to preprare the raw data for manipulation in python (`.RDS` -> `.csv`)
 ⌞ `/01-HoC_preparation_IB.py` to prepare the raw `.csv` data for analysis (sentence splitting and running language models)
 ⌞ `/02-HoC_vader-textblob_IB.py` to conduct preliminary analysis with `vader` and `textblob`
 ⌞ `/03-emotion-recognition_with_BERT.ipynb` - the actual emotion recognition
 ⌞ `/create_venv.txt` instructions to create the  `venv`
 ⌞ `/package links.txt` links to install packages if/ where needed
 ⌞ `/plots.r` file to create plots based on the predicted data
 ⌞ `/sampling_emotive_statements.R` samples for face validity
- `data/`
 ⌞ `BERT-in` data needed in `code/03-emotion-recognition_with_BERT.ipynb`
  ⌞ `House_of_commons_2019ff_labelled_test.csv` - labelled data to train neural model on
  ⌞ `House_of_commons_2019ff_to_predict.csv` - data to predict (selected sentences)
  ⌞ `isear_preprocessed.csv` - ISEAR (International Survey on Emotion Antecedents and Reactions) dataset (https://paperswithcode.com/dataset/isear) for training neural model
 ⌞ `BERT-out` data produced by  `code/03-emotion-recognition_with_BERT.ipynb`
  ⌞ `House_of_commons_predicted.csv` data with predictions
  ⌞ `House_of_commons_validation.csv` predictions on seen data
 ⌞ `preprocessed` data produced by  `code/00-...`-`code/02-...`, partly not uploaded on GitHub due to space restrictions
  ⌞ `1-House_of_commons_2019ff_preprocessed_head100.csv` a sample output of `code/01-HoC_preparation_IB.py`
  ⌞ `data-overview.txt` a text file of file names that should be produced when running the code (and saved in `/data/preprocessed`)
