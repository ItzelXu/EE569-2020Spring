% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020
clc
clear all;
addpath('bm3d');
y = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_noisy.raw');
z = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_gray.raw');
y = raw22D(y, 320, 320);
y = matTranspose(y);
z = raw22D(z, 320, 320);
z = matTranspose(z);

% to fit the data type of the BM3D algorithm
y = im2double(uint8(y));
z = im2double(uint8(z));


y_est = BM3D(y, 0.1);
psnr = getPSNR(z, y_est)

figure,

subplot(1, 2, 1);
imshow(z);
title('Original');
subplot(1, 2, 2);
imshow(y_est);
title('Denoised');
