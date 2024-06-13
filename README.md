# BCI_Final_Project

## Introduction
We aim to explore emotion classification through a brain-computer interface system using the SEED dataset. The SEED dataset categorizes emotions into three types: neutral, positive, and negative. In the data preprocessing phase, we apply a bandpass filter and ASR to filter the data, and use ICA to reduce the number of channels and remove noise. We then process the SEED dataset using several machine learning and deep learning models: Decision Tree, Gaussian, KNN, Random Forest, Linear SVM, Polynomial SVM, RBF SVM, CNN, and LSTM. The performance of these models is evaluated based on three metrics: precision, recall, and accuracy. Ultimately, we identify the model that best distinguishes between the three types of emotions.

## Dataset
### Experimental Design and Data Collection
This experiment was designed as a visual stimulation study using fifteen Chinese film clips, which included positive, neutral, and negative emotions as stimuli. Each film clip lasted approximately 4 minutes and was carefully edited to ensure emotional coherence and maximize emotional significance. The experimental procedure included 15 trials, with a 5-second hint before each clip, a 45-second self-assessment period after each clip, and a 15-second rest period. The order of the clips was arranged so that two clips with the same target emotion were not shown consecutively. Participants were required to complete a questionnaire immediately after watching each clip to report their emotional reactions.



## Model Framework


## Validation & Results
We not only used various machine learning models to classify the three types of emotions in the SEED dataset but also incorporated two deep learning models, CNN and LSTM, into our exploration. Additionally, we used ICA to denoise the data, making it easier to process and increasing the likelihood of successful classification. This approach aims to enhance the effectiveness of the models during training.



## References
1. Wei-Long Zheng, and Bao-Liang Lu, Investigating Critical Frequency Bands and Channels for EEG-based Emotion Recognition with Deep Neural Networks, accepted by IEEE Transactions on Autonomous Mental Development (IEEE TAMD) 7(3): 162-175, 2015. [link] [BibTex]

2. Ruo-Nan Duan, Jia-Yi Zhu and Bao-Liang Lu, Differential Entropy Feature for EEG-based Emotion Classification, Proc. of the 6th International IEEE EMBS Conference on Neural Engineering (NER). 2013: 81-84.

3. https://github.com/rasoulghaznavi/MLSEED
