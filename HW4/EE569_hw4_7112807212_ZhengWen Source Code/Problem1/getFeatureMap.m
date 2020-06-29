% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function feature_map_25 = getFeatureMap(img)

[m,n] = size(img);
feature_map_25 = zeros(m,n,25);

L5 = [ 1, 4, 6, 4, 1];
E5 = [-1,-2, 0, 2, 1];
S5 = [-1, 0, 2, 0,-1];
W5 = [-1, 2, 0,-2, 1];
R5 = [ 1,-4, 6,-4, 1];

L5L5 = L5' * L5;
L5E5 = L5' * E5;
L5S5 = L5' * S5;
L5W5 = L5' * W5;
L5R5 = L5' * R5;

E5L5 = E5' * L5;
E5E5 = E5' * E5;
E5S5 = E5' * S5;
E5W5 = E5' * W5;
E5R5 = E5' * R5;

S5L5 = S5' * L5;
S5E5 = S5' * E5;
S5S5 = S5' * S5;
S5W5 = S5' * W5;
S5R5 = S5' * R5;

W5L5 = W5' * L5;
W5E5 = W5' * E5;
W5S5 = W5' * S5;
W5W5 = W5' * W5;
W5R5 = W5' * R5;

R5L5 = R5' * L5;
R5E5 = R5' * E5;
R5S5 = R5' * S5;
R5W5 = R5' * W5;
R5R5 = R5' * R5;
% 1-5
feature_map_25(:, :, 1) = filtImg(img, L5L5);
feature_map_25(:, :, 2) = filtImg(img, L5E5);
feature_map_25(:, :, 3) = filtImg(img, L5S5);
feature_map_25(:, :, 4) = filtImg(img, L5W5);
feature_map_25(:, :, 5) = filtImg(img, L5R5);
% 6-10
feature_map_25(:, :, 6) = filtImg(img, E5L5);
feature_map_25(:, :, 7) = filtImg(img, E5E5);
feature_map_25(:, :, 8) = filtImg(img, E5S5);
feature_map_25(:, :, 9) = filtImg(img, E5W5);
feature_map_25(:, :, 10) = filtImg(img, E5R5);
% 11-15
feature_map_25(:, :, 11) = filtImg(img, S5L5);
feature_map_25(:, :, 12) = filtImg(img, S5E5);
feature_map_25(:, :, 13) = filtImg(img, S5S5);
feature_map_25(:, :, 14) = filtImg(img, S5W5);
feature_map_25(:, :, 15) = filtImg(img, S5R5);
% 16-20
feature_map_25(:, :, 16) = filtImg(img, W5L5);
feature_map_25(:, :, 17) = filtImg(img, W5E5);
feature_map_25(:, :, 18) = filtImg(img, W5S5);
feature_map_25(:, :, 19) = filtImg(img, W5W5);
feature_map_25(:, :, 20) = filtImg(img, W5R5);
% 21-25
feature_map_25(:, :, 21) = filtImg(img, R5L5);
feature_map_25(:, :, 22) = filtImg(img, R5E5);
feature_map_25(:, :, 23) = filtImg(img, R5S5);
feature_map_25(:, :, 24) = filtImg(img, R5W5);
feature_map_25(:, :, 25) = filtImg(img, R5R5);

% feature_map_25 = feature_map_25 - mean(mean(feature_map_25));

end