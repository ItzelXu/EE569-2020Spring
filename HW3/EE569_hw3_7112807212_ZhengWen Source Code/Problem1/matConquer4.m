% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function res = matConquer4(upper_left, upper_right, lower_left, lower_right)
[m, n] = size(upper_left);
res = zeros(2*m, 2*n);

for i=1:m
    for j=1:n
        res(i, j) = upper_left(i,j);
        res(i, n + j) = upper_right(i,j);
        res(m + i, j) = lower_left(i,j);
        res(m + i, n + j) = lower_right(i,j);
    end
end
end