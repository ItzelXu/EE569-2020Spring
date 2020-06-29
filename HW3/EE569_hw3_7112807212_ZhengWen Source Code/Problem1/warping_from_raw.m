% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function res = warping_from_raw(raw)
addpath('E:\Chrome Download\EE569\Week3\basicOperations');
[R, G, B] = raw23D(raw, 512, 512);
[m, n] = size(R);

% R

[R_upper_left, R_upper_right, R_lower_left, R_lower_right] = matDivide4(R);
% Coordinate transform
[I, J] = warping_EGM_I( R_lower_right );

R_lower_right = project2Cir( R_lower_right, I, J);
R_lower_left = matFlip( project2Cir( matFlip( R_lower_left, 2), I, J ), 2);
R_upper_right = matFlip( project2Cir( matFlip( R_upper_right, 1), I, J ), 1);
R_upper_left = matFlip( matFlip( project2Cir( matFlip( matFlip( R_upper_left, 1), 2), I, J ), 1), 2);
R_res = matConquer4(R_upper_left, R_upper_right, R_lower_left, R_lower_right);

% G
[G_upper_left, G_upper_right, G_lower_left, G_lower_right] = matDivide4(G);
G_lower_right = project2Cir( G_lower_right, I, J );
G_lower_left = matFlip( project2Cir( matFlip( G_lower_left, 2), I, J ), 2);
G_upper_right = matFlip( project2Cir( matFlip( G_upper_right, 1), I, J ), 1);
G_upper_left = matFlip( matFlip( project2Cir( matFlip( matFlip( G_upper_left, 1), 2), I, J ), 1), 2);
G_res = matConquer4(G_upper_left, G_upper_right, G_lower_left, G_lower_right);
% B
[B_upper_left, B_upper_right, B_lower_left, B_lower_right] = matDivide4(B);
B_lower_right = project2Cir( B_lower_right, I, J );
B_lower_left = matFlip( project2Cir( matFlip(B_lower_left, 2), I, J ), 2);
B_upper_right = matFlip( project2Cir( matFlip(B_upper_right, 1), I, J ), 1);
B_upper_left = matFlip( matFlip( project2Cir( matFlip( matFlip( B_upper_left, 1), 2), I, J ), 1), 2);
B_res = matConquer4(B_upper_left, B_upper_right, B_lower_left, B_lower_right);

res = zeros(m,n,3);
res(:, :, 1) = R_res;
res(:, :, 2) = G_res;
res(:, :, 3) = B_res;

end