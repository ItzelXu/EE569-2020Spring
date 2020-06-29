# Name: Zheng Wen
# USC ID: 7112807212
# USC Email: zwen1423@usc.edu
# Submission Date 4/3/2020

import tensorflow as tf
import numpy as np
from tensorflow.keras.layers import Flatten, MaxPooling2D, Conv2D, Input, Dense
from tensorflow.keras.models import Model
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.datasets import cifar10
from tensorflow.keras.initializers import Ones, he_normal, GlorotNormal
from tensorflow.keras.regularizers import l1, l2
from tensorflow.keras.optimizers import SGD
import matplotlib.pyplot as plt


mini_batch_size = 16
num_epochs = 40
learning_rate = 0.0005

kernel_init = Ones(), he_normal(), GlorotNormal()
kernel_regularizer = l1(0.001), l2(0.001)

(train_data, train_label), (test_data, test_label) = cifar10.load_data()
train_label = to_categorical(train_label, 10)
test_label = to_categorical(test_label, 10)

train_data = train_data.astype('float32') / 255
test_data = test_data.astype('float32') / 255

input_shape = np.shape(train_data)[1:]

x_input = Input(shape=input_shape)
x_cov1 = Conv2D(6, (5, 5), kernel_initializer=kernel_init[1], kernel_regularizer=kernel_regularizer[1], activation='relu')(x_input)
x_pool1 = MaxPooling2D()(x_cov1)
x_cov2 = Conv2D(16, (5, 5), kernel_initializer=kernel_init[1], kernel_regularizer=kernel_regularizer[1], activation='relu')(x_pool1)
x_pool2 = MaxPooling2D()(x_cov2)
x_flatten = Flatten()(x_pool2)
x_dense1 = Dense(120, kernel_initializer=kernel_init[1], kernel_regularizer=kernel_regularizer[1], activation='relu')(x_flatten)
x_dense2 = Dense(84, kernel_initializer=kernel_init[1], kernel_regularizer=kernel_regularizer[1], activation='relu')(x_dense1)
x_output = Dense(10, kernel_initializer=kernel_init[1], kernel_regularizer=kernel_regularizer[1], activation='softmax')(x_dense2)

LeNet_5 = Model(inputs=x_input, outputs=x_output)
LeNet_5.compile(metrics=['accuracy'], loss='categorical_crossentropy')
LeNet_5.summary()

training_process = LeNet_5.fit(train_data, train_label, 
                               batch_size=mini_batch_size,    
                               epochs=num_epochs,
                               validation_data=(test_data, test_label), 
                               optimizer=SGD(learning_rate=learning_rate),
                               )

plt.figure()
plt.plot(training_process.history['accuracy'], label='train')
plt.plot(training_process.history['val_accuracy'], label='test')
plt.legend()
plt.xlabel('Epoch')
plt.ylabel('Accuracy')

plt.figure()
plt.plot(training_process.history['loss'], label='train')
plt.plot(training_process.history['val_loss'], label='test')
plt.legend()
plt.xlabel('Epoch')
plt.ylabel('Multiclass Cross Entropy')