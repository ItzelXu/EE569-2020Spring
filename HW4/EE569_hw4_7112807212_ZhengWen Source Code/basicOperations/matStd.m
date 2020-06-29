% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = matStd(X)

[m,n] = size(X);
mean_val = matMean(X);

for i = 1:n
    for j = 1:m
        X(j,i) = X(j,i) - mean_val(i);
    end
end

res = zeros(1, n);

for i = 1:n
    sum_i = 0;
    for j = 1:m
        sum_i = sum_i + X(j, i) * X(j, i);
    end
    res(1,i) = sqrt(sum_i / (m - 1));
end

end