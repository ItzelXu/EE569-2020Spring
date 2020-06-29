% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = matMul(A, B)

[m,n1] = size(A);
[n2,n] = size(B);
res = zeros(m,n);
for i=1:m
    for j=1:n
        temp = 0;
        for k = 1: n1
            temp = temp + A(i, k) * B(k, j);
        end
        res(i,j) = temp;
    end
    
end
end