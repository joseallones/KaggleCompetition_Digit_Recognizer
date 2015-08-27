
##R Code for [Kaggle Contest: Digit Recognizer](Kaggle Contest: Digit Recognizer)

## From Kaggle's competition details:

Classify handwritten digits using the famous MNIST data

The goal in this competition is to take an image of a handwritten single digit, and determine what that digit is. As the competition progresses, we will release tutorials which explain different machine learning algorithms and help you to get started.

The data for this competition were taken from the MNIST dataset. The MNIST ("Modified National Institute of Standards and Technology") dataset is a classic within the Machine Learning community that has been extensively studied. More detail about the dataset, including Machine Learning algorithms that have been tried on it and their levels of success, can be found at http://yann.lecun.com/exdb/mnist/index.html.

## Data Files
The data files train.csv and test.csv contain gray-scale images of hand-drawn digits, from zero through nine.

Each image is 28 pixels in height and 28 pixels in width, for a total of 784 pixels in total. Each pixel has a single pixel-value associated with it, indicating the lightness or darkness of that pixel, with higher numbers meaning darker. This pixel-value is an integer between 0 and 255, inclusive.

##Packages and methods
The algorithms "svmLinear", "svmPoly", "rf" (random forest) and "rpart2" (clasification trees) of the caret package were used to fit models. 
##Results
"svmPoly" with parameters scale = 0.1, degree = 3, C = 1  gives the best performance: 97.2% precision in test set. 
