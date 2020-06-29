% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

addpath('E:\Chrome Download\EE569\Week4\basicOperations')
raw = readraw('E:\Chrome Download\EE569\Week4\HW4_image\comp.raw');
img = raw22D(raw, 600, 450);
imwrite(uint8(img), 'E:\Chrome Download\EE569\Week4\HW4_image\comp.tif')
% img = histeq(uint8(img));

img = matSubMean(img);
feature_map_25 = getFeatureMap(img);
energy_row_25 = featureAverage_abs_win_Gaussian(feature_map_25, 15, 10);
% energy_row_25 = featureAverage_abs_win(feature_map_25, 15);
energy_row_15 = energyRow_25_15(energy_row_25);

energy_row_14 = matDotDiv(energy_row_15, energy_row_15(1, :));
energy_row_14 = energy_row_14(2: end, :);

energy_row_PCA = PCA_dim(energy_row_14', 5);

% label_14 = kmeans(energy_row_14', 6, 'MaxIter', 2000)';
% label_14_map = reshape(label_14, 600, 450)';
% image_14 = lb_mp2img(label_14_map, 6);
% figure(1);
% imshow(uint8(image_14));
% imwrite(uint8(image_14), 'image_14_avg_31.tif')

label_PCA = kmeans(energy_row_PCA', 6, 'MaxIter', 2000)';
label_PCA_map = reshape(label_PCA, 600, 450)';
image_PCA = lb_mp2img(label_PCA_map, 6);
figure(2);
imshow(uint8(image_PCA));
imwrite(uint8(image_PCA), 'image_14_avg_31_PCA_Gauss.tif')

res = holeFilling(image_PCA);
imshow(uint8(res));
imwrite(uint8(res), 'Final.tif');
% feature_map_25 = getFeatureMap(img_downsampled);
% energy_row_25 = featureAverage_abs_win(feature_map_25, 7);
% energy_row_15 = energyRow_25_15(energy_row_25);
% 
% energy_row_14 = energy_row_15 ./ energy_row_15(1, :);
% energy_row_14 = energy_row_14(2: end, :);
% 
% energy_row_PCA = PCA_dim(energy_row_14, 4);
% 
% label_14 = kmeans(energy_row_14', 6, 'MaxIter', 2000)';
% label_14_map = reshape(label_14, 300, 225)';
% image_14 = lb_mp2img(label_14_map, 6);
% figure(1);
% imshow(uint8(image_14));
% 
% label_PCA = kmeans(energy_row_PCA', 6, 'MaxIter', 2000)';
% label_PCA_map = reshape(label_PCA, 300, 225)';
% image_PCA = lb_mp2img(label_PCA_map, 6);
% figure(2);
% imshow(uint8(image_PCA));