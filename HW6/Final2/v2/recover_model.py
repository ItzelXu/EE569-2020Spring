# -*- coding: utf-8 -*-
"""
Created on Sun May  3 06:22:00 2020

@author: Lenovo
"""

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
from sklearn.ensemble import RandomForestClassifier
import time
from sklearn.metrics import confusion_matrix
from sklearn.metrics import plot_confusion_matrix
import matplotlib.pyplot as plt

(x_train, y_train), (x_test, y_test) = cifar10.load_data()

x_train_later = np.reshape(x_train.copy(), (50000, -1))
y_train_later = y_train.copy()

x_train = np.reshape(x_train, (50000, -1))
num_train = 1000   # number of each training class

if num_train != 5000:
    data_set = []    
    for i in range(10):
        temp = np.concatenate(
            (x_train[np.where(y_train == i)[0], :], y_train[np.where(y_train == i)[0], :]), 
            axis=1)
        temp = temp[:num_train]
        if isinstance(data_set, list):
            data_set = temp
        else:
            data_set = np.concatenate((data_set, temp), axis=0)

    np.random.shuffle(data_set)

    x_train = np.reshape(data_set[:, :-1], (num_train * 10, 32, 32, 3))
    y_train = data_set[:, -1][:, None]
else:
    x_train = np.reshape(x_train, (num_train * 10, 32, 32, 3))
    
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')

x_train /= 255
x_test /= 255
num_classes = 10 

# train
def Shrink(X, shrinkArg):
    win = shrinkArg['win']
    stride = shrinkArg['stride']
    X = view_as_windows(X, (1,win,win,1), (1,stride,stride,1))
    return block_reduce(X.reshape(X.shape[0], X.shape[1], X.shape[2], -1), (1, 2, 2, 1), np.max)

def Concat(X, concatArg):
    return X

# PixelHop++
SaabArgs = [{'num_AC_kernels':-1, 'needBias':False, 'useDC':True, 'batch':None, 'cw':False}, 
            {'num_AC_kernels':-1, 'needBias':True, 'useDC':True, 'batch':None, 'cw':True},
            {'num_AC_kernels':-1, 'needBias':True, 'useDC':True, 'batch':None, 'cw':True}]
shrinkArgs = [{'func':Shrink, 'win':5, 'stride':1}, 
             {'func': Shrink, 'win':5, 'stride':1},
             {'func': Shrink, 'win':5, 'stride':1}]
concatArg = {'func':Concat}

p2 = Pixelhop2(depth=3, TH1=0.001, TH2=0.0001, SaabArgs=SaabArgs, shrinkArgs=shrinkArgs, concatArg=concatArg)

f = open('pixelHop2.pkl', 'rb') 
p2 = pickle.load(f)
f.close()

f = open('feature_set.pkl', 'rb') 
feature_set = pickle.load(f)
f.close()

f = open('lag_rep.pkl', 'rb') 
lag_rep = pickle.load(f)
f.close()

f = open('svm.pkl', 'rb') 
svmclf = pickle.load(f)
f.close()

output_test = p2.transform(x_test)

x_test_trans = []
for i in range(3):
    output_i_test = output_test[i].reshape(output_test[i].shape[0], -1)[:, feature_set[i]]
    if isinstance(x_test_trans, list): 
        x_test_trans = lag_rep[i].transform(output_i_test)
    else:
        x_test_trans = np.concatenate((x_test_trans, lag_rep[i].transform(output_i_test)), axis=1)


score = svmclf.score(x_test_trans, np.squeeze(y_test))
print('Predicted score =', score)