# KaggleCompetition_Digit_Recognizer
Code and data for the Digit Recognizer competition on Kaggle

Data Files

The data files train.csv and test.csv contain gray-scale images of hand-drawn digits, from zero through nine.

Each image is 28 pixels in height and 28 pixels in width, for a total of 784 pixels in total. Each pixel has a single pixel-value associated with it, indicating the lightness or darkness of that pixel, with higher numbers meaning darker. This pixel-value is an integer between 0 and 255, inclusive.

This repo includes a simple model (based on the method "svmLinear" of caret package) to predict forest categories using some cartographic variables.

The dataset was taken from the UCI Machine learning repository. More details here: https://archive.ics.uci.edu/ml/datasets/Covertype

This link https://archive.ics.uci.edu/ml/machine-learning-databases/covtype/covtype.data.gz contains the full dataset. Download and unzip it in your project.
