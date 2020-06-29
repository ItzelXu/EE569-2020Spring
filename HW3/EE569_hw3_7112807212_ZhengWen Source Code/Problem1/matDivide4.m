% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function [upper_left, upper_right, lower_left, lower_right] = matDivide4(img)
[m, n] = size(img);
upper_left = zeros(m/2, n/2);
upper_right = zeros(m/2, n/2);
lower_left = zeros(m/2, n/2);
lower_right = zeros(m/2, n/2);

for i=1:m/2
    for j=1:m/2
        upper_left(i,j) = img(i, j);
        upper_right(i,j) = img(i, n/2 + j);
        lower_left(i,j) = img(m/2 + i, j);
        lower_right(i,j) = img(m/2 + i, n/2 + j);
    end
end
end