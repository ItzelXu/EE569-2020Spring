% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = raw22D(raw, m, n)

res = zeros(m,n);
k=1;
for j=1:n
    for i=1:m
        res(i,j) = raw(k);
        k = k+1;
    end
end
res = matTranspose(res);
end

