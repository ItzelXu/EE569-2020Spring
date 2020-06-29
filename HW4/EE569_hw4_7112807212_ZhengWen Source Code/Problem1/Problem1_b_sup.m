% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

addpath('E:\Chrome Download\EE569\Week4\basicOperations')

%% train
train_path = 'E:\Chrome Download\EE569\Week4\HW4_image\train\';       
train_dir  = dir([train_path '*.raw']);
energy_all_15_train = zeros(15, length(train_dir));
energy_all_25_train = zeros(25, length(train_dir));
for i = 1:length(train_dir)
    train_raw = readraw([train_path train_dir(i).name]);
    train_img = raw22D(train_raw, 128, 128);
    imwrite(uint8(train_img), [erase([train_path train_dir(i).name], '.raw') '.tif'])
    train_img = matSubMean(train_img);
    feature_map_25_train = getFeatureMap(train_img);
    energy_25_train = featureAverage_abs(feature_map_25_train);
    energy_15_train = energy_25_15(energy_25_train);
    energy_all_25_train(:, i) = energy_25_train;
    energy_all_15_train(:, i) = energy_15_train;
end
energy_all_3_train = PCA_dim(energy_all_15_train', 3);

%% test
test_path = 'E:\Chrome Download\EE569\Week4\HW4_image\test_ranged\';       
test_dir  = dir([test_path '*.raw']);
energy_all_15_test = zeros(15, length(test_dir));
energy_all_25_test = zeros(25, length(test_dir));
for i = 1:length(test_dir)
    test_raw = readraw([test_path test_dir(i).name]);
    test_img = raw22D(test_raw, 128, 128);
    imwrite(uint8(test_img), [erase([test_path test_dir(i).name], '.raw') '.tif'])
    test_img = matSubMean(test_img);
    feature_map_25_test = getFeatureMap(test_img);
    energy_25_test = featureAverage_abs(feature_map_25_test);
    energy_15_test = energy_25_15(energy_25_test);
    energy_all_25_test(:, i) = energy_25_test;
    energy_all_15_test(:, i) = energy_15_test;
end
energy_all_3_test = PCA_dim(energy_all_15_test', 3);

lable_train = [ones(1,9), 2 * ones(1,9), 3 * ones(1,9), 4 * ones(1,9)]';

t = templateSVM('Standardize',true,'KernelFunction','linear', 'SaveSupportVectors', true);
SVM = fitcecoc(energy_all_3_train', lable_train,'Learners',t);
label_pred_SVM = predict(SVM, energy_all_3_test');



RandomFrst = TreeBagger(3, energy_all_15_train', lable_train);
label_pred_RandomFrst = predict(RandomFrst, energy_all_15_test');

