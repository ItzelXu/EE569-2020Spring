% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

addpath('E:\Chrome Download\EE569\Week4\basicOperations')

train_path = 'E:\Chrome Download\EE569\Week4\HW4_image\test_ranged\';       
train_dir  = dir([train_path '*.raw']);
energy_all_15 = zeros(15, length(train_dir));
energy_all_25 = zeros(25, length(train_dir));
energy_all_14 = zeros(14, length(train_dir));
for i = 1:length(train_dir)
    train_raw = readraw([train_path train_dir(i).name]);
    train_img = raw22D(train_raw, 128, 128)';
    imwrite(uint8(train_img), [erase([train_path train_dir(i).name], '.raw') '.tif'])
%     figure(i)
%     imshow(uint8(train_img))
%     train_img_seq(:,:,i) = train_img;
%     train_img = im2double(uint8(train_img));
%     train_img = histeq(train_img);

    train_img = matSubMean(train_img);

%     train_img_smooth = graySmooth(train_img);
%     train_img_processed = train_img - train_img_smooth;
    
    feature_map_25 = getFeatureMap(train_img);
    energy_25 = featureAverage_abs(feature_map_25);
    energy_15 = energy_25_15(energy_25);
    
%     energy_15 = energy_15 - mean(energy_15);
    
    
%     energy_14 = energy_15_14(energy_15);
    energy_all_25(:, i) = energy_25;
    energy_all_15(:, i) = energy_15;
%     energy_all_14(:, i) = energy_14;    
end
energy_all_3 = PCA_dim(energy_all_15', 3);

label_me_15 = k_means(energy_all_15, 4);
label_sys_15 = kmeans(energy_all_15',4);

label_sys_3 = kmeans(energy_all_3',4);
label_me_3 = k_means(energy_all_3, 4);
