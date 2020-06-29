% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = Tgen(I)

[m,n] = size(I);
res = zeros(m,n);
for i=1:m
    for j=1:n
        res(i,j) = ((I(i,j)+0.5)/(m*n))*255;
    end
end
end