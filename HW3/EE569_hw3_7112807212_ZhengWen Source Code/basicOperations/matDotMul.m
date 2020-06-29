% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function res = matDotMul(A, B)

[m,n] = size(A);
res = zeros(m,n);
for i=1:m
    for j=1:n
        res(i,j)=A(i,j)*B(i,j);
    end
end
end