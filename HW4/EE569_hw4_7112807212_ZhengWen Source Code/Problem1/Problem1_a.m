% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

addpath('E:\Chrome Download\EE569\Week4\basicOperations')

train_path = 'E:\Chrome Download\EE569\Week4\HW4_image\train\';       
train_dir  = dir([train_path '*.raw']);
energy_all_15 = zeros(15, length(train_dir));
energy_all_25 = zeros(25, length(train_dir));
% energy_all_14 = zeros(14, length(train_dir));
for i = 1:length(train_dir)
    train_raw = readraw([train_path train_dir(i).name]);
    train_img = raw22D(train_raw, 128, 128);
    imwrite(uint8(train_img), [erase([train_path train_dir(i).name], '.raw') '.tif'])
    train_img = matSubMean(train_img);
    feature_map_25 = getFeatureMap(train_img);
    energy_25 = featureAverage_abs(feature_map_25);
    energy_15 = energy_25_15(energy_25);
    energy_all_25(:, i) = energy_25;
    energy_all_15(:, i) = energy_15;
%     energy_all_14(:, i) = energy_14;    
end
energy_all_3 = PCA_dim(energy_all_15', 3);
label_me_3 = [ones(1,9), 2 * ones(1,9), 3 * ones(1,9), 4 * ones(1, 9)];

scatter3(energy_all_3(1, label_me_3 == 1), energy_all_3(2, label_me_3 == 1), energy_all_3(3, label_me_3 == 1), 'r');
hold on
scatter3(energy_all_3(1, label_me_3 == 2), energy_all_3(2, label_me_3 == 2), energy_all_3(3, label_me_3 == 2), 'g');
scatter3(energy_all_3(1, label_me_3 == 3), energy_all_3(2, label_me_3 == 3), energy_all_3(3, label_me_3 == 3), 'b');
scatter3(energy_all_3(1, label_me_3 == 4), energy_all_3(2, label_me_3 == 4), energy_all_3(3, label_me_3 == 4), 'k');
legend('blanket', 'brick', 'grass', 'rice')


mean_C1 = mean(energy_all_15(:, 1:9), 2);
mean_C2 = mean(energy_all_15(:, 10:18), 2);
mean_C3 = mean(energy_all_15(:, 19:27), 2);
mean_C4 = mean(energy_all_15(:, 28:36), 2);
mean_total = mean(energy_all_15, 2);

sample_C1 = energy_all_15(:, 1:9);
sample_C2 = energy_all_15(:, 10:18);
sample_C3 = energy_all_15(:, 19:27);
sample_C4 = energy_all_15(:, 28:36);

intra_C1 = sum((sample_C1 - mean_C1) .^ 2, 2);
intra_C2 = sum((sample_C2 - mean_C2) .^ 2, 2);
intra_C3 = sum((sample_C3 - mean_C3) .^ 2, 2);
intra_C4 = sum((sample_C4 - mean_C4) .^ 2, 2);

intra_sig = intra_C1 + intra_C2 + intra_C3 + intra_C4;
inter_sig = 9 * ((mean_C1 - mean_total) .^ 2 + (mean_C2 - mean_total) .^ 2 + ...
    (mean_C3 - mean_total) .^ 2 + (mean_C4 - mean_total) .^ 2);
ratio = inter_sig ./ intra_sig;
[max_val, max_arg] = max(ratio);
[min_val, min_arg] = min(ratio);

disp('max')
disp(max_arg); % E5E5
disp('min')
disp(min_arg); % L5S5 / S5L5