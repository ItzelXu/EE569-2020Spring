% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

raw = readraw('GearTooth.raw');
img = raw22D(raw, 250, 250);
img = matTranspose(img);
img = fixedThresholdDithering(img, 150);
img_cp = img;
figure(1)
imshow(img_cp);
imwrite(img_cp, 'GearTooth_ori.tif');
[m,n] = size(img);
img_inv = ImgInverse_1(img);
%% find center of small circle
% inversed, shrinked, find alone.
figure(2)
imshow(img_inv);
imwrite(img_inv, 'GearTooth_inv.tif');

img_inv_shrink = bwmorph(img_inv, 'shrink', Inf);
figure(3)
imshow(img_inv_shrink);
imwrite(img_inv_shrink, 'GearTooth_inv_shrinked.tif');

[num_circle, small_cir_center] = countAlone(img_inv_shrink);
lar_cir_cen_i = 0;
lar_cir_cen_j = 0;
for i=1:4
    lar_cir_cen_i = lar_cir_cen_i + small_cir_center(i, 1);
    lar_cir_cen_j = lar_cir_cen_j + small_cir_center(i, 2);
end
lar_cir_cen_i = round(lar_cir_cen_i / 4);
lar_cir_cen_j = round(lar_cir_cen_j / 4);

radius = 0;
%LR
find_i = lar_cir_cen_i;
while img(find_i, lar_cir_cen_j)
    find_i = find_i - 1;
end
radius = radius + abs(lar_cir_cen_i - find_i);
find_i = lar_cir_cen_i;
while img(find_i, lar_cir_cen_j)
    find_i = find_i + 1;
end
radius = radius + abs(lar_cir_cen_i - find_i);
%UD
find_j = lar_cir_cen_j;
while img(lar_cir_cen_i, find_j)
    find_j = find_j - 1;
end
radius = radius + abs(lar_cir_cen_j - find_j);
find_j = lar_cir_cen_j;
while img(lar_cir_cen_i, find_j)
    find_j = find_j + 1;
end
radius = radius + abs(lar_cir_cen_j - find_j);
radius = fix(radius / 4);

figure(4)
img_skeleton = bwmorph(img, 'skel', Inf);
% used to find middle position in case of wrong mark on other gears because
% of asysmatric.
imshow(img_skeleton);
imwrite(img_skeleton, 'GearTooth_skeletonized.tif');

miss_pos_1 = [];
miss_pos_2 = [];
for i = lar_cir_cen_i - radius : lar_cir_cen_i + radius
    j = round(lar_cir_cen_j + sqrt(radius^2 - (i - lar_cir_cen_i)^2));
    if img(i, j) == 1 && img(2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j) == 0 && countBondforSinglePoint(img, 2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j) == 0
        if 2 * lar_cir_cen_j - j < n / 2
            miss_pos_1(end + 1, :) = [2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j];
        else
            miss_pos_2(end + 1, :) = [2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j];
        end
    end
    j = round(lar_cir_cen_j - sqrt(radius^2 - (i - lar_cir_cen_i)^2));
    if img(i, j) == 1 && img(2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j) == 0 && countBondforSinglePoint(img, 2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j) == 0
        if 2 * lar_cir_cen_j - j < n / 2
            miss_pos_1(end + 1, :) = [2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j];
        else
            miss_pos_2(end + 1, :) = [2 * lar_cir_cen_i - i, 2 * lar_cir_cen_j - j];
        end
    end
end
[num_miss_1, ~] = size(miss_pos_1);
miss1_pos_avg_i = 0;
miss1_pos_avg_j = 0;
for i=1:num_miss_1
    miss1_pos_avg_i = miss1_pos_avg_i + miss_pos_1(i, 1);
    miss1_pos_avg_j = miss1_pos_avg_j + miss_pos_1(i, 2);
end
miss1_pos_avg_i = round(miss1_pos_avg_i / num_miss_1);
miss1_pos_avg_j = round(miss1_pos_avg_j / num_miss_1);

[num_miss_2, ~] = size(miss_pos_2);
miss2_pos_avg_i = 0;
miss2_pos_avg_j = 0;
for i=1:num_miss_2
    miss2_pos_avg_i = miss2_pos_avg_i + miss_pos_2(i, 1);
    miss2_pos_avg_j = miss2_pos_avg_j + miss_pos_2(i, 2);
end
miss2_pos_avg_i = round(miss2_pos_avg_i / num_miss_2);
miss2_pos_avg_j = round(miss2_pos_avg_j / num_miss_2);

img(miss2_pos_avg_i, miss2_pos_avg_j) = 1;
img(miss1_pos_avg_i, miss1_pos_avg_j) = 1;

figure(5)
imshow(img);
imwrite(img, 'GearTooth_sol.tif');
