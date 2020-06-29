% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations');

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem2\LightHouse.raw');
img = raw22D(img, 750, 500);
img = matTranspose(img);

img_randTh = randThDithering(img);

imshow(img_randTh);

imwrite(uint8(img_randTh), 'random.tif')