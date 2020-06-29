% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function res = matAddConst(mat, const)

[m,n] = size(mat);
for i=1:m
    for j=1:n
        mat(i,j) = mat(i,j) + const;
    end
end
res = mat;
end