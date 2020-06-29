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
Puppy_1 = im2single(imread('Puppy_1.jpg'));

H_1_g = single(rgb2gray(Husky_1));
H_2_g = single(rgb2gray(Husky_2));
H_3_g = single(rgb2gray(Husky_3));
P_1_g = single(rgb2gray(Puppy_1));

[f1,d1] = vl_sift(H_1_g);
[f2,d2] = vl_sift(H_2_g);
[f3,d3] = vl_sift(H_3_g);
[f4,d4] = vl_sift(P_4_g);

% [f1,d1] = vl_sift(H_1_g, 'PeakThresh', 0.07, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
% [f2,d2] = vl_sift(H_2_g, 'PeakThresh', 0.07, 'EdgeThresh',5) ;
% [f3,d3] = vl_sift(H_3_g, 'PeakThresh', 0.07, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
% [f4,d4] = vl_sift(P_4_g, 'PeakThresh', 0.07, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;

% [f1,d1] = vl_sift(H_1_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
% [f2,d2] = vl_sift(H_2_g, 'PeakThresh', 0.02, 'EdgeThresh',5) ;
% [f3,d3] = vl_sift(H_3_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
% [f4,d4] = vl_sift(P_4_g, 'PeakThresh', 0.02, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;

scale_3 = f3(3, :);
[max_3, maxind_3] = max(sum(d3));
d3_max = d3(:, maxind_3);
f3_max = f3(:, maxind_3);

dis = zeros(1, size(f1, 2));
for i=1:size(f1, 2)
    dis(1,i) = sqrt(sum((double(d3_max) - double(d1(:, i))) .^2));
end

[value, ind] = min(dis);
f1_match = f1(:, ind);

% dist_3max_1 = sqrt(sum((d3_max - d1) .^ 2, 1));
% [min_dist_3max_1, minind_dist_3max_1] = min(dist_3max_1);
% d1_match = d1(:, minind_dist_3max_1);
% f1_match = f1(:, minind_dist_3max_1);

figure(1)
imshow(Husky_3);
hold on
h1 = vl_plotframe(f3_max) ; set(h1,'color','r','linewidth',2);

figure(2)
imshow(Husky_1);
hold on
h2 = vl_plotframe(f1_match) ; set(h2,'color','r','linewidth',2);