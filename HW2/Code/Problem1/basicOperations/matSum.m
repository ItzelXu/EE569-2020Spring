% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = matSum(A)

[m,n] = size(A);
res = 0;
for i=1:m
    for j=1:n
        res = res + A(i,j);
    end
end
end