% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('E:\Chrome Download\EE569\Week2\HW2\Problem1\edges-master')
%% a
E = imread('Dogs_Sobel.tif');
E = 1-im2double(E);
[thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg(E, 'Dogs_GT.mat');
[P,R,F] = bestPRF(cntR, sumR, cntP, sumP)

%% b
E = imread('Gallery_Canny.tif');
[thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg(E, 'Gallery_GT.mat');
[P,R,F] = bestPRF(cntR, sumR, cntP, sumP)

%% c
E = imread('Gallery_SE.tif');
E = im2double(E);
[thrs,cntR,sumR,cntP,sumP,V] = edgesEvalImg(E, 'Gallery_GT.mat');
[P,R,F] = bestPRF(cntR, sumR, cntP, sumP)