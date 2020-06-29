% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020
clc
clear all;
G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Dog.raw');
G = raw22D(G, 600, 532);
G = matTranspose(G);
G_uint8 = uint8(G);
imshow(G_uint8);
[m,n] = size(G);
reconstruct = G;
reconstruct(:,:,2) = G;
reconstruct(:,:,3) = G; 

reconstruct(:,:,1) = Red_MHC(G,m,n);
reconstruct(:,:,2) = Green_MHC(G,m,n);
reconstruct(:,:,3) = Blue_MHC(G,m,n);

reconstruct = uint8(reconstruct);
imshow(reconstruct)

G_ori = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Dog_ori.raw');
[G_ori_Red, G_ori_Green, G_ori_Blue] = raw23D(G_ori,600,532);
G_ori_Red = matTranspose(G_ori_Red);
G_ori_Green = matTranspose(G_ori_Green);
G_ori_Blue = matTranspose(G_ori_Blue);

PSNR_R = PSNRCal(reconstruct(:,:,1), G_ori_Red);
PSNR_G = PSNRCal(reconstruct(:,:,2), G_ori_Green);
PSNR_B = PSNRCal(reconstruct(:,:,3), G_ori_Blue);
PSNR_avg = (PSNR_R + PSNR_G + PSNR_B) / 3;