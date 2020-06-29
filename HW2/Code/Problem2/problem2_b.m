% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations');

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem2\LightHouse.raw');
img = raw22D(img, 750, 500);
img = matTranspose(img);

img = im2double(uint8(img));

FS = (1/16)*[0 0 0; 0 0 7; 3 5 1];
JJN =(1/48)*[0 0 0 0 0; 0 0 0 0 0; 0 0 0 7 5; 3 5 7 5 3; 1 3 5 3 1];
SK = (1/42)*[0 0 0 0 0; 0 0 0 0 0; 0 0 0 8 4; 2 4 8 4 2; 1 2 4 2 1];

FS_re =(1/16)*[0 0 0; 7 0 0; 1 5 3];
JJN_re=(1/48)*[0 0 0 0 0; 0 0 0 0 0; 5 7 0 0 0; 3 5 7 5 3; 1 3 5 3 1];
SK_re =(1/42)*[0 0 0 0 0; 0 0 0 0 0; 4 8 0 0 0; 2 4 8 4 2; 1 2 4 2 1];

img_FS =  errorDiffusion(img, FS, FS_re);
figure(1);
imshow(img_FS);
imwrite(img_FS, 'FS.tif')
img_JJN = errorDiffusion(img, JJN, JJN_re);
figure(2);
imshow(img_JJN);
imwrite(img_JJN, 'JJN.tif')
img_SK = errorDiffusion(img, SK, SK_re);
figure(3);
imshow(img_SK);
imwrite(img_SK, 'SK.tif')