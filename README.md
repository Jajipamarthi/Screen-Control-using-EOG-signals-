# Screen-Control-using-EOG
## Description:
The idea of project is collect the EOG signal from the user and classify them to neutral, left, right, up, down and blink. Based on the decision of a SVM-kNN hybrid classifier, the cursor of the screen moves in that direction and depending the blinks interval of time, the brightness of the screen is controlled.

The bio-radio is used to collect the sensor signals from the user. With help of Lab Stream Layer application, the signal chucks are collected and saved. The files are imported to MATLAB for preprossesing the signals and feature extraction. MAchine Learning Toolbox in MATLAB is used to classify the data, additional PCA is performed to minimize the features dataset.
