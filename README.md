# BCI_Final_Project

## Introduction
We aim to explore emotion classification through a brain-computer interface system using the SEED dataset. The SEED dataset categorizes emotions into three types: neutral, positive, and negative. In the data preprocessing phase, we apply a bandpass filter and ASR to filter the data, and use ICA to reduce the number of channels and remove noise. We then process the SEED dataset using several machine learning and deep learning models: Decision Tree, Gaussian, KNN, Random Forest, Linear SVM, Polynomial SVM, RBF SVM, CNN, and LSTM. The performance of these models is evaluated based on three metrics: precision, recall, and accuracy. Ultimately, we identify the model that best distinguishes between the three types of emotions.

## Dataset
### Experimental Design and Data Collection
This experiment was designed as a visual stimulation study using fifteen Chinese film clips, which included positive, neutral, and negative emotions as stimuli. Each film clip lasted approximately 4 minutes and was carefully edited to ensure emotional coherence and maximize emotional significance. The experimental procedure included 15 trials, with a 5-second hint before each clip, a 45-second self-assessment period after each clip, and a 15-second rest period. The order of the clips was arranged so that two clips with the same target emotion were not shown consecutively. Participants were required to complete a questionnaire immediately after watching each clip to report their emotional reactions.

EEG signals and eye movements were collected with the 62-channel ESI NeuroScan System and SMI eye-tracking glasses. The experimental scene and the corresponding EEG electrode placement are shown in the following figures.The EEG cap according to the international 10 - 20 system for 62 channels is shown below:

<p align="center">
   <img src="https://github.com/sherryyu0823/BCI_Final_Project/blob/main/Result/channels.png"/>
</p>

### Subjects
Fifteen Chinese subjects (7 males and 8 females; MEAN: 23.27, STD: 2.37) participated in the experiments. To protect personal privacy, we hide their names and indicate each subject with a number from 1 to 15. 1st-5th and 8th-14th subjects (12 subjects) have EEG and eye movement data while the 6th, 7th and 15th subjects only have EEG data.


## Model Framework
In our Brain-Computer Interface (BCI) research, we have developed a comprehensive framework that spans from data acquisition to the application of machine learning models. The input mechanism relies on EEG data collected from subjects during experiments. Each subject participates in three sessions, approximately one week apart, resulting in 45 MATLAB (.mat) files. Each subject file contains 16 arrays: 15 arrays hold segmented and preprocessed EEG data from 15 trials per experiment, organized in a channel-by-data format and labeled with emotional tags (0 for negative, 1 for neutral, and 2 for positive).

For signal preprocessing, we downsampled the EEG data to 256 Hz and applied a bandpass filter ranging from 0 to 75 Hz to isolate relevant frequency components. Independent Component Analysis (ICA) was employed to remove artifacts, ensuring cleaner data for analysis.

Data segmentation involved extracting EEG segments corresponding to the duration of each movie shown during the experiments, aligning the data with the stimulus for accurate analysis.

Feature extraction was robust, incorporating both differential entropy (DE) features and asymmetry-based features. DE features were quickly tested for classification methods without extensive preprocessing. Additionally, we computed differential asymmetry (DASM) and rational asymmetry (RASM) features by calculating differences and ratios between DE features of 27 pairs of hemispheric asymmetry electrodes. To enhance feature reliability, we smoothed the data using moving averages and linear dynamic systems (LDS) approaches.

For classification, we utilized a range of machine learning models, including Decision Tree, Gaussian, K-Nearest Neighbors (KNN), Random Forest, Linear Support Vector Machine (SVM), Convolutional Neural Networks (CNN), Recurrent Neural Networks (RNN), and Long Short-Term Memory networks (LSTM). Each model was selected to handle the complexities and nuances of EEG data, ensuring a robust and accurate BCI system.

## Validation & Results
We not only used various machine learning models to classify the three types of emotions in the SEED dataset but also incorporated two deep learning models, CNN and LSTM, into our exploration. Additionally, we used ICA to denoise the data, making it easier to process and increasing the likelihood of successful classification. This approach aims to enhance the effectiveness of the models during training.

<p align="center">
   <img src="https://github.com/sherryyu0823/BCI_Final_Project/blob/main/Result/RESULT.jpg"/>
</p>

## References
1. Wei-Long Zheng, and Bao-Liang Lu, Investigating Critical Frequency Bands and Channels for EEG-based Emotion Recognition with Deep Neural Networks, accepted by IEEE Transactions on Autonomous Mental Development (IEEE TAMD) 7(3): 162-175, 2015. [link] [BibTex]

2. Ruo-Nan Duan, Jia-Yi Zhu and Bao-Liang Lu, Differential Entropy Feature for EEG-based Emotion Classification, Proc. of the 6th International IEEE EMBS Conference on Neural Engineering (NER). 2013: 81-84.

3. https://github.com/rasoulghaznavi/MLSEED
