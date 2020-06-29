% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = matMean(X)

[m,n] = size(X);

res = zeros(1, n);

for i = 1:n
    sum_i = 0;
    for j = 1:m
        sum_i = sum_i + X(j, i);
    end
    res(1,i) = sum_i / m;
end
end