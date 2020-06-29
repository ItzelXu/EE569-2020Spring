% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

raw_left = readraw('left.raw');
ori_left = uint8(raw2img3(raw_left, 720, 480));
imwrite(ori_left, 'ori_left.tif');

raw_right = readraw('right.raw');
ori_right = uint8(raw2img3(raw_right, 720, 480));
imwrite(ori_right, 'ori_right.tif');

raw_mid = readraw('middle.raw');
ori_mid = uint8(raw2img3(raw_mid, 720, 480));
imwrite(ori_mid, 'ori_mid.tif');

% Read the first image from the image set.
gray_left = rgb2gray(ori_left);
points_left = detectSURFFeatures(gray_left);
[features_left, points_left] = extractFeatures(gray_left, points_left);

gray_mid = rgb2gray(ori_mid);
points_mid = detectSURFFeatures(gray_mid);
[features_mid, points_mid] = extractFeatures(gray_mid, points_mid);

gray_right = rgb2gray(ori_right);
points_right = detectSURFFeatures(gray_right);
[features_right, points_right] = extractFeatures(gray_right, points_right);

indexPairs_lm = matchFeatures(features_left, features_mid, 'Unique', true);

matched_left2mid = points_left(indexPairs_lm(:,1), :);
matched_mid2left = points_mid(indexPairs_lm(:,2), :);   
% [11,14,41,61] [14,18,57,61]
matched_left2mid = matched_left2mid([14,20,57,61], :);
matched_mid2left = matched_mid2left([14,20,57,61], :);

indexPairs_rm = matchFeatures(features_right, features_mid, 'Unique', true);
matched_right2mid = points_right(indexPairs_rm(:,1), :);
matched_mid2right = points_mid(indexPairs_rm(:,2), :);  
matched_right2mid = matched_right2mid([31, 43, 45, 53], :);
matched_mid2right = matched_mid2right([31, 43, 45, 53], :);
f1 = figure(1);
showMatchedFeatures(ori_left, ori_mid, matched_left2mid, matched_mid2left, 'montage'); % L and M
saveas(f1, 'feature_lm.tif')
f2 = figure(2);
showMatchedFeatures(ori_mid, ori_right, matched_mid2right, matched_right2mid, 'montage') % M and R
saveas(f2, 'feature_rm.tif')
%% Right

[m_mid, n_mid] = size(gray_mid);

feature_loc_right2mid = matched_right2mid.Location;
feature_loc_mid2right= matched_mid2right.Location - n_mid;
feature_loc_mid2right(:, 2)= feature_loc_mid2right(:, 2) + n_mid;

feature_loc_right2mid_mean = [(feature_loc_right2mid(1,1)+feature_loc_right2mid(2,1)+feature_loc_right2mid(3,1)+feature_loc_right2mid(4,1)) / 4,...
    (feature_loc_right2mid(1,2)+feature_loc_right2mid(2,2)+feature_loc_right2mid(3,2)+feature_loc_right2mid(4,2)) / 4];
feature_loc_mid2right_mean = [(feature_loc_mid2right(1,1)+feature_loc_mid2right(2,1)+feature_loc_mid2right(3,1)+feature_loc_mid2right(4,1)) / 4,...
    (feature_loc_mid2right(1,2)+feature_loc_mid2right(2,2)+feature_loc_mid2right(3,2)+feature_loc_mid2right(4,2)) / 4];
H_right2mid = transform_compute(feature_loc_right2mid, feature_loc_mid2right);
% [left_new_I, left_new_J] = in2out_paro(ori_left, T_left2mid);
[changed_r, new_rm, mid_ul_I_rm, mid_ul_J_rm, loc_rm] = in2out_paro(ori_right, H_right2mid, ori_mid, feature_loc_right2mid_mean, feature_loc_mid2right_mean, 2);


%% Left
feature_loc_left2mid = matched_left2mid.Location;
feature_loc_mid2left= matched_mid2left.Location + n_mid;
feature_loc_mid2left(:, 2)= feature_loc_mid2left(:, 2) - n_mid;
feature_loc_left2mid_mean = [(feature_loc_left2mid(1,1)+feature_loc_left2mid(2,1)+feature_loc_left2mid(3,1)+feature_loc_left2mid(4,1)) / 4,...
    (feature_loc_left2mid(1,2)+feature_loc_left2mid(2,2)+feature_loc_left2mid(3,2)+feature_loc_left2mid(4,2)) / 4];
feature_loc_mid2left_mean = [(feature_loc_mid2left(1,1)+feature_loc_mid2left(2,1)+feature_loc_mid2left(3,1)+feature_loc_mid2left(4,1)) / 4,...
    (feature_loc_mid2left(1,2)+feature_loc_mid2left(2,2)+feature_loc_mid2left(3,2)+feature_loc_mid2left(4,2)) / 4];
H_left2mid = transform_compute(feature_loc_left2mid, feature_loc_mid2left);
% [left_new_I, left_new_J] = in2out_paro(ori_left, T_left2mid);
[changed_l, new_lm, mid_ul_I_lm, mid_ul_J_lm, loc_lm] = in2out_paro(ori_left, H_left2mid, ori_mid, feature_loc_left2mid_mean, feature_loc_mid2left_mean, 1);


% showMatchedFeatures(ori_left, ori_mid, matched_left2mid, matched_mid2left)
% Initialize all the transforms to the identity matrix. Note that the
% projective transform is used here because the building images are fairly
% close to the camera. Had the scene been captured from a further distance,
% an affine transform would suffice.

figure(4), imshow(uint8(changed_l)); figure(3);imshow(uint8(changed_r));
imwrite(uint8(changed_l), 'change_l.tif'), imwrite(uint8(changed_r), 'changed_r.tif');
figure(5), imshow(uint8(new_lm)); figure(6);imshow(uint8(new_rm));
imwrite(uint8(new_lm), 'new_lm.tif'), imwrite(uint8(new_rm), 'new_rm.tif');

%% concatinate
[m_left, n_left] = size(new_lm(:, :, 1));
[m_right, n_right] = size(new_rm(:, :, 1));

fine_tune_lm_rm = 0;
det_I = mid_ul_I_rm - mid_ul_I_lm + fine_tune_lm_rm;

res_left_R = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_left_G = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_left_B = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_left_R(det_I + 1: det_I + m_left, 1: n_left) = new_lm(:, :, 1);
res_left_G(det_I + 1: det_I + m_left, 1: n_left) = new_lm(:, :, 2);
res_left_B(det_I + 1: det_I + m_left, 1: n_left) = new_lm(:, :, 3);

res_right_R = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_right_G = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_right_B = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_right_R(1: m_right, n_left - n_mid + 1: n_left - n_mid + n_right) = new_rm(:, :, 1);
res_right_G(1: m_right, n_left - n_mid + 1: n_left - n_mid + n_right) = new_rm(:, :, 2);
res_right_B(1: m_right, n_left - n_mid + 1: n_left - n_mid + n_right) = new_rm(:, :, 3);


loc_left = zeros(max(m_left, m_right), n_left + n_right - n_mid);
loc_right = zeros(max(m_left, m_right), n_left + n_right - n_mid);
loc_left(det_I + 1: det_I + m_left, 1: n_left) = loc_lm;
loc_right(1: m_right, n_left - n_mid + 1: n_left - n_mid + n_right) = loc_rm;

res_R = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_G = zeros(max(m_left, m_right), n_left + n_right - n_mid);
res_B = zeros(max(m_left, m_right), n_left + n_right - n_mid);

for i = 1:max(m_left, m_right)
    for j = 1: n_left + n_right - n_mid
        if loc_left(i,j) == 1 && loc_right(i,j) == 1
            res_R(i,j) = (res_left_R(i, j) + res_right_R(i, j)) / 2;
            res_G(i,j) = (res_left_G(i, j) + res_right_G(i, j)) / 2;
            res_B(i,j) = (res_left_B(i, j) + res_right_B(i, j)) / 2;
        else
            if loc_left(i,j) == 1
                res_R(i,j) = res_left_R(i, j, 1);
                res_G(i,j) = res_left_G(i, j, 1);
                res_B(i,j) = res_left_B(i, j, 1);
            end
            if loc_right(i,j) == 1
                res_R(i,j) = res_right_R(i, j, 1);
                res_G(i,j) = res_right_G(i, j, 1);
                res_B(i,j) = res_right_B(i, j, 1);
            end
        end
    end
end

res(:, :, 1) = res_R;
res(:, :, 2) = res_G;
res(:, :, 3) = res_B;
figure(7);
imshow(uint8(res));
imwrite(uint8(res), 'sol_P2.tif');
%% a finer way
res_finer = res;
fine_tune_I = -1;
fine_tune_J = -2;
mid_ul_I_rm = mid_ul_I_rm + fine_tune_I;
mid_ul_J_lm = mid_ul_J_lm + fine_tune_J;
res_finer(mid_ul_I_rm + 1: mid_ul_I_rm + m_mid, mid_ul_J_lm + 1: mid_ul_J_lm + n_mid, :) = ori_mid;
figure(8);
imshow(uint8(res_finer));
imwrite(uint8(res_finer), 'sol_P2_finer.tif');

