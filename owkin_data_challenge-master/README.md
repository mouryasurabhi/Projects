# OWKIN_DATA_CHALLENGE-Surabhi Sai Mourya
Data Challenge to predict lung cancer survival time which is published on [challenge data](https://challengedata.ens.fr/) 

## DESCRIPTION
This repository is for the Owkin data challenge(predicting lung cancer survival time) as part of the application for the "Machine Learning Scientist - Medical imaging - Internship". It contains the code, the data used and detailed explanations.

# ABOUT THE CHALLENGE
The challenge is a supervised survival prediction problem to predict the survival time of a patient (remaining days to live) from the data given, they are one three-dimensional CT scan (grayscale image) and a set of pre-extracted quantitative imaging features, and the clinical data. Each patient corresponds to one CT scan and one binary segmentation mask. The CT scans and the associated segmentation masks are subsets of two public datasets:
1. NSCLC Radiomics (a subset of 285 patients)
2. NSCLC RadioGenomics(subset of 141 patients)

## Data description
### Data
Inputs 
For each patient, I provided 2 inputs:
1. Radiomics features (an ensemble of 53 quantitative features per patient, extracted from the scan).
2. Clinical data

#### Radiomics features
Radiomics features are stored in the file Radiomic_features.csv, where each row contains the 53 feature values, for each patient. Those features were pre-extracted from the scans.

#### Clinical data
Clinical data contains basic information for each patient and each patient is described by age, the source data, and the TNM staging of cancer. 

#### Metric
The concordance index (C-index) is used as the metric.


# My approach to the problem:
I have decided to proceed with the Cox model for the survival analysis as in the papers I have read it performed well compared to others. For the Cox model, I wanted to Use glmnet package but it was not available for windows so decided to go with lifelines instead. Firstly, I decided to go with the traditional approach i.e extracting the features from the images then survival analysis using the features. But the efficiency of the model was less and took a lot to time to run as I have used a 3d CNN, so I decided to use the pre_extracted features. After preprocessing the data ,for the feature selection did it two steps:
1. Remove collinear features using Pearson correlation
2. Remove features with low variances so that the convergence does not fail.

Then built a model of Coxph which is compatible with Scikit-learn so I can cross-validate and tune the parameters of the model much more easily.
The final score after the submission is "0.7248" submitted under the name "saimourya_surabhi"

# Other approaches I wanted to try
1. For feature extraction and feature selection , I wanted to try Auto.ml techniques.
2. Implement an efficient 3D CNN for the feature extraction process.
3. Try Gausssian process latent variable model for dimesnion reduction instead of PCA.

# Refrences:
1. P. Afshar, A. Mohammadi, K. N. Plataniotis, A. Oikonomou and H. Benali, "From Handcrafted to Deep-Learning-Based Cancer Radiomics: Challenges and Opportunities," in IEEE Signal Processing Magazine, vol. 36, no. 4, pp. 132-160, July 2019.doi: 10.1109/MSP.2019.2900993
2. Haarburger, Christoph & Weitz, Philippe & Rippel, Oliver & Merhof, Dorit. (2018). Image-based Survival Analysis for Lung Cancer Patients using CNNs. 
3. Chaddad, Ahmad & Desrosiers, Christian & Toews, Matthew & Abdulkarim, Bassam. (2017). Predicting survival time of lung cancer patients using radiomic analysis. Oncotarget. 8. 10.18632/oncotarget.22251. 
4. Barrett, J. E., and Coolen, A. C. C. ( 2016) Covariate dimension reduction for survival data via the Gaussian process latent variable model. Statist. Med., 35: 1340– 1353. doi: 10.1002/sim.6784.
5. Shen, Chen & Liu, Zhenyu & Guan, Min & Song, Jiangdian & Lian, Yucheng & Wang, Shuo & Tang, Zhenchao & Dong, Di & Kong, Lingfei & Wang, Meiyun & Shi, Dapeng & Tian, Jie. (2017). 2D and 3D CT Radiomics Features Prognostic Performance Comparison in Non-Small Cell Lung Cancer. Translational oncology. 10. 886-894. 10.1016/j.tranon.2017.08.007. 
6. Aerts, H., Velazquez, E., Leijenaar, R. et al. Decoding tumour phenotype by noninvasive imaging using a quantitative radiomics approach. Nat Commun 5, 4006 (2014). https://doi.org/10.1038/ncomms500
