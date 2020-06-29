% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = Ipadd(ori)
[m,n] = size(ori);
res = zeros(2*m, 2*n);

for i = 1:m
    for j = 1:n
        res(i,j) = 1 + 4*ori(i,j);
        res(i+m,j) = 3 + 4*ori(i,j);
        res(i,j+m) = 2 + 4*ori(i,j);
        res(i+m,j+m) = 4*ori(i,j);
    end    
end
    
end