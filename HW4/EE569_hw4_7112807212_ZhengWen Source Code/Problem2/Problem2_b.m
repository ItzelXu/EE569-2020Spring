% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020


addpath(genpath('D:\MATLAB\vlfeat-0.9.21-bin\vlfeat-0.9.21'));
run('D:\MATLAB\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup');

vl_version verbose

Husky_1 = im2single(imread('Husky_1.jpg'));
Husky_2 = im2single(imread('Husky_2.jpg'));
Husky_3 = im2single(imread('Husky_3.jpg'));
Puppy_4 = im2single(imread('Puppy_1.jpg'));

H_1_g = single(rgb2gray(Husky_1));
H_2_g = single(rgb2gray(Husky_2));
H_3_g = single(rgb2gray(Husky_3));
P_4_g = single(rgb2gray(Puppy_4));

[f1,d1] = vl_sift(H_1_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
[f2,d2] = vl_sift(H_2_g, 'PeakThresh', 0.02, 'EdgeThresh',5) ;
[f3,d3] = vl_sift(H_3_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
[f4,d4] = vl_sift(P_4_g, 'PeakThresh', 0.02, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;


%% 
% [matches, scores] = vl_ubcmatch(d1,d3); 
% 
% [~, perm] = sort(scores, 'descend') ;
% matches = matches(:, perm) ;
% scores  = scores(perm) ;
% fig1 = figure(1) ; clf ;
% imagesc(cat(2, Husky_1, Husky_3)) ;
% x1 = f1(1,matches(1,:)) ;
% x2 = f3(1,matches(2,:)) + size(Husky_1,2) ;
% y1 = f1(2,matches(1,:)) ;
% y2 = f3(2,matches(2,:)) ;
% hold on ;
% h = line([x1 ; x2], [y1 ; y2]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% vl_plotframe(f1(:,matches(1,:))) ;
% f3(1,:) = f3(1,:) + size(Husky_1,2) ;
% vl_plotframe(f3(:,matches(2,:))) ;
% axis image off ;

%% 
% [matches, scores] = vl_ubcmatch(d3,d2); 
% 
% [~, perm] = sort(scores, 'descend') ;
% matches = matches(:, perm) ;
% scores  = scores(perm) ;
% fig1 = figure(2) ; clf ;
% imagesc(cat(2, Husky_3, Husky_2)) ;
% x1 = f3(1,matches(1,:)) ;
% x2 = f2(1,matches(2,:)) + size(Husky_3,2) ;
% y1 = f3(2,matches(1,:)) ;
% y2 = f2(2,matches(2,:)) ;
% hold on ;
% h = line([x1 ; x2], [y1 ; y2]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% vl_plotframe(f3(:,matches(1,:))) ;
% f2(1,:) = f2(1,:) + size(Husky_3,2) ;
% vl_plotframe(f2(:,matches(2,:))) ;
% axis image off ;

%% 
% [matches, scores] = vl_ubcmatch(d3,d4); 
% 
% [~, perm] = sort(scores, 'descend') ;
% matches = matches(:, perm) ;
% scores  = scores(perm) ;
% fig1 = figure(3) ; clf ;
% imagesc(cat(2, Husky_3, Puppy_4)) ;
% x1 = f3(1,matches(1,:)) ;
% x2 = f4(1,matches(2,:)) + size(Husky_3,2) ;
% y1 = f3(2,matches(1,:)) ;
% y2 = f4(2,matches(2,:)) ;
% hold on ;
% h = line([x1 ; x2], [y1 ; y2]) ;
% set(h,'linewidth', 1, 'color', 'b') ;
% vl_plotframe(f3(:,matches(1,:))) ;
% f4(1,:) = f4(1,:) + size(Husky_3,2) ;
% vl_plotframe(f4(:,matches(2,:))) ;
% axis image off ;

%% 
[matches, scores] = vl_ubcmatch(d1,d4); 

[~, perm] = sort(scores, 'descend') ;
matches = matches(:, perm) ;
scores  = scores(perm) ;
fig1 = figure(4) ; clf ;
imagesc(cat(2, Husky_1, Puppy_4)) ;
x1 = f1(1,matches(1,:)) ;
x2 = f4(1,matches(2,:)) + size(Husky_1,2) ;
y1 = f1(2,matches(1,:)) ;
y2 = f4(2,matches(2,:)) ;
hold on ;
h = line([x1 ; x2], [y1 ; y2]) ;
set(h,'linewidth', 1, 'color', 'b') ;
vl_plotframe(f1(:,matches(1,:))) ;
f4(1,:) = f4(1,:) + size(Husky_1,2) ;
vl_plotframe(f4(:,matches(2,:))) ;
axis image off ;
