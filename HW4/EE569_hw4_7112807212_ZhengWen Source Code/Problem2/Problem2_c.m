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

[f1,d1] = vl_sift(H_1_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
[f2,d2] = vl_sift(H_2_g, 'PeakThresh', 0.02, 'EdgeThresh',5) ;
[f3,d3] = vl_sift(H_3_g, 'PeakThresh', 0.017, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;
[f4,d4] = vl_sift(P_4_g, 'PeakThresh', 0.02, 'Levels', 4, 'Octaves', 5, 'Magnif', 2) ;

d1 = double(d1);
d2 = double(d2);
d3 = double(d3);
d4 = double(d4);

rmpath('D:\MATLAB\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\noprefix');
[codebook, center, sumd, d] = kmeans(double([d1, d2, d3, d4]'),8);
[min_val, min_idx] = min(d);

center = center';
% center_f = f3(:, min_idx);
% figure(1)
% image(Husky_3)
% h1 = vl_plotframe(center_f); 
% set(h1,'color','r','linewidth',3) ;

codebook_ordered = zeros(size(codebook));
dist_ori = sum(center .^ 2, 1);

[dist_sort, index] = sort(dist_ori);

center_ordered = center(:, index);
for i=1:8
    codebook_ordered(codebook == index(i)) = i;
end

[~, n3] = size(f3);
class_3 = zeros(1, n3);
for i = 1:n3
    [val, cls] = min(sum((center_ordered - d3(:, i)) .^ 2, 1));
    class_3(i) = cls;
end
fig2 = figure(2);
count_3 = zeros(1, 8);
for i = 1:size(class_3, 2)
    count_3(class_3(i)) = count_3(class_3(i)) + 1;
end

% count_3 = count_3 / sum(count_3);
bar(count_3);
ylim([0 60])
title('Hist of Husky_3');

[~, n1] = size(f1);
class_1 = zeros(1, n1);
for i = 1:n1
    [val, cls] = min(sum((center_ordered - d1(:, i)) .^ 2, 1));
    class_1(i) = cls;
end
fig3 = figure(3);
count_1 = zeros(1, 8);
for i = 1:size(class_1, 2)
    count_1(class_1(i)) = count_1(class_1(i)) + 1;
end

% count_1 = count_1 / sum(count_1);
bar(count_1);
ylim([0 60])
title('Hist of Husky_1');

[~, n2] = size(f2);
class_2 = zeros(1, n2);
for i = 1:n2
    [val, cls] = min(sum((center_ordered - d2(:, i)) .^ 2, 1));
    class_2(i) = cls;
end
fig4 = figure(4);

count_2 = zeros(1, 8);
for i = 1:size(class_2, 2)
    count_2(class_2(i)) = count_2(class_2(i)) + 1;
end

% count_2 = count_2 / sum(count_2);
bar(count_2);
ylim([0 60])
title('Hist of Husky_2');


[~, n4] = size(f4);
class_4 = zeros(1, n4);
for i = 1:n4
    [val, cls] = min(sum((center_ordered - d4(:, i)) .^ 2, 1));
    class_4(i) = cls;
end
fig5 = figure(5);

count_4 = zeros(1, 8);
for i = 1:size(class_4, 2)
    count_4(class_4(i)) = count_4(class_4(i)) + 1;
end

% count_4 = count_4 / sum(count_4);
bar(count_4);
ylim([0 60])
title('Hist of Puppy_1');

diff_31 = sqrt(sum((count_3 - count_1) .^ 2));
diff_32 = sqrt(sum((count_3 - count_2) .^ 2));
diff_34 = sqrt(sum((count_3 - count_4) .^ 2));

