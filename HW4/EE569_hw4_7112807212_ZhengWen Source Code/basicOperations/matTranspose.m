% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function trans = matTranspose(mat)

[m,n] = size(mat);
trans = zeros(n,m);
for i=1:m
    for j=1:n
        trans(j,i) = mat(i,j);
    end
end
end