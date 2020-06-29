% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

clc;
clear all;
G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_noisy.raw');
G_ori = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_gray.raw');
G = reshape(G, 320, 320);
G = G';
G_ori = reshape(G_ori, 320, 320);
G_ori = G_ori';
J = imnlmfilt(G,...
    'DegreeOfSmoothing',30,...
    'SearchWindowSize', 7,...
    'ComparisonWindowSize', 3);
% imshow(uint8(J))
PSNR = PSNRCal(J, G_ori)