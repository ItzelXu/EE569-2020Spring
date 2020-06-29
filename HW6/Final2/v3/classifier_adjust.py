from pixelhop2 import Pixelhop2
from cross_entropy import Cross_Entropy
from lag import LAG
from tensorflow.keras.datasets import cifar10
import numpy as np
from skimage.util import view_as_windows
import pickle
from skimage.measure import block_reduce
from llsr import LLSR
from sklearn import svm
import time
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_confusion_matrix
import matplotlib.pyplot as plt
import multiprocessing as mp
from joblib import Parallel, delayed
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from sklearn.ensemble import RandomForestClassifier

np.random.seed(20)	

f = open('x_test_trans_single.pkl', 'rb')
x_test_trans = pickle.load(f)
f.close()

f = open('x_train_trans_single.pkl', 'rb')
x_train_trans = pickle.load(f)
f.close()

(x_train, y_train), (x_test, y_test) = cifar10.load_data()

# rfclf = RandomForestClassifier(n_estimators=100, random_state=4)
# rfclf.fit(x_train_trans, np.squeeze(y_train))	
# score = rfclf.score(x_test_trans, np.squeeze(y_test))
# print('Predicted score =', score)
# score_tr = rfclf.score(x_train_trans, np.squeeze(y_train))	
# print('Train score =', score_tr)


svmclf = svm.SVC(C=2, kernel='rbf', gamma=12)
svmclf.fit(x_train_trans, np.squeeze(y_train))
score = svmclf.score(x_test_trans, np.squeeze(y_test))
print('Predicted score =', score)
# score_tr = svmclf.score(x_train_trans, np.squeeze(y_train))
# print('Train score =', score_tr)
