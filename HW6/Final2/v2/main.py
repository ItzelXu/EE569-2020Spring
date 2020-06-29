# -*- coding: utf-8 -*-
"""
Created on Mon Apr 20 16:16:06 2020

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
start_time = time.time()

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
p2.fit(x_train)

f = open('pixelHop2.pkl', 'wb') 
pickle.dump(p2, f)
f.close()

print()
print('Pixel Hop saved!')
print()

# f = open('pixelHop2.pkl', 'rb') 
# p2 = pickle.load(f)
# f.close()

factor = 1/8
num_train_later = int(5000 * factor)  # number of each training class
if num_train_later != 5000:
    data_set = []    
    for i in range(10):
        temp = np.concatenate(
            (x_train_later[np.where(y_train_later == i)[0], :], 
             y_train_later[np.where(y_train_later == i)[0], :]), 
            axis=1)
        np.random.shuffle(temp)
        temp = temp[:num_train_later]
        if isinstance(data_set, list):
            data_set = temp
        else:
            data_set = np.concatenate((data_set, temp), axis=0)

    np.random.shuffle(data_set)

    x_train_later = np.reshape(data_set[:, :-1], (num_train_later * 10, 32, 32, 3))
    y_train_later = data_set[:, -1][:, None]
else:
    x_train_later = np.reshape(x_train_later, (num_train_later * 10, 32, 32, 3))
    
x_train_later = x_train_later.astype('float32')
x_train_later /= 255

output_train = p2.transform(x_train_later)

Ns = 1500
feature_set = []

for each in output_train:
    each = each.reshape(each.shape[0], -1)
    ce = Cross_Entropy(num_class=10, num_bin=5)
    feat_ce = np.zeros(each.shape[-1])
    for k in range(each.shape[-1]):
        feat_ce[k] = ce.KMeans_Cross_Entropy(each[:,k].reshape(-1,1), y_train_later)
        # print(" --> KMeans ce: %s"%str(feat_ce[k]))
    feature_set.append(np.argpartition(feat_ce, np.min( (Ns, each.shape[-1] - 1) ))[:np.min( (Ns, each.shape[-1]) )])
    print("------- DONE -------\n")

f = open('feature_set.pkl', 'wb') 
pickle.dump(feature_set, f)
f.close()

print()
print('feature_set saved!')
print()

# f = open('feature_set.pkl', 'rb') 
# feature_set = pickle.load(f)
# f.close()

lag_rep = [
    LAG(encode='distance', num_clusters=[6] * 10, alpha=10, learner=LLSR(onehot=False)),
    LAG(encode='distance', num_clusters=[6] * 10, alpha=10, learner=LLSR(onehot=False)),
    LAG(encode='distance', num_clusters=[5] * 10, alpha=10, learner=LLSR(onehot=False))
    ]

x_train_trans = []
for i in range(3):
    output_i_train = output_train[i].reshape(output_train[i].shape[0], -1)[:, feature_set[i]]
    lag_rep[i].fit(output_i_train, y_train_later)
    if isinstance(x_train_trans, list): 
        x_train_trans = lag_rep[i].transform(output_i_train)
    else:
        x_train_trans = np.concatenate((x_train_trans, lag_rep[i].transform(output_i_train)), axis=1)

f = open('lag_rep.pkl', 'wb') 
pickle.dump(lag_rep, f)
f.close()

print()
print('lag_rep saved!')
print()

# f = open('lag_rep.pkl', 'rb') 
# lag_rep = pickle.load(f)
# f.close()

# svmclf = svm.SVC(C=2.5, kernel='rbf', gamma=11) # 50000
# svmclf = svm.SVC(C=2, kernel='rbf', gamma=11) # 25000
# svmclf = svm.SVC(C=1, kernel='rbf', gamma=5) # 12500
svmclf = svm.SVC(C = 0.2, kernel='rbf', gamma=1.3) # 6250
# svmclf = svm.SVC(C = 0.005, kernel='rbf', gamma=0.8) # 3120
# svmclf = svm.SVC(C = 0.0005, kernel='rbf', gamma=0.8) # 1560
svmclf.fit(x_train_trans, np.squeeze(y_train_later))



f = open('svm.pkl', 'wb') 
pickle.dump(svmclf, f)
f.close()

print()
print('svm saved!')
print()

# f = open('rf.pkl', 'rb') 
# rf = pickle.load(f)
# f.close()

end_time = time.time()
print('training time is ', end_time - start_time)

# test
start = time.time()

output_test = p2.transform(x_test)

x_test_trans = []
for i in range(3):
    output_i_test = output_test[i].reshape(output_test[i].shape[0], -1)[:, feature_set[i]]
    if isinstance(x_test_trans, list): 
        x_test_trans = lag_rep[i].transform(output_i_test)
    else:
        x_test_trans = np.concatenate((x_test_trans, lag_rep[i].transform(output_i_test)), axis=1)

# svmclf = svm.SVC(C = 0.005, kernel='rbf', gamma=0.1) # 3120
# svmclf = svm.SVC(C = 30, kernel='rbf', gamma=1)
# svmclf.fit(x_train_trans, np.squeeze(y_train_later))
score = svmclf.score(x_test_trans, np.squeeze(y_test))
print('Predicted score =', score)
print('Test time =', time.time() - start)

# score_tr = svmclf.score(x_train_trans, np.squeeze(y_train_later))
# print('Train score =', score_tr)


# rfclf = RandomForestClassifier(n_estimators=200)
# rfclf.fit(x_train_trans, np.squeeze(y_train_later))
# score = rfclf.score(x_test_trans, np.squeeze(y_test))
# print('Predicted score =', score)
# score_tr = rfclf.score(x_train_trans, np.squeeze(y_train_later))
# print('Train score =', score_tr)



# pred = svmclf.predict(x_test_trans)
# cfm = confusion_matrix(y_test, pred, normalize='true')

# disp = plot_confusion_matrix(svmclf, x_test_trans, y_test, normalize='true', include_values=False)
# # x = [12500, 6250, 3120, 1560]
# # y = [58.67,53.25,45.65,31.29]
# x_wrong = x_test[np.where(np.squeeze(pred) != np.squeeze(y_test))]
# wrong_pred = pred[np.where(np.squeeze(pred) != np.squeeze(y_test))]
# wrong_true = y_test[np.where(np.squeeze(pred) != np.squeeze(y_test))]

# num_show = 2
# plt.imshow(x_wrong[num_show,:,:])
# print('pred', wrong_pred[num_show])
# print('true', wrong_true[num_show])
