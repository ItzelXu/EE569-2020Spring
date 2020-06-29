% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function new = panelNomalize(pattern)

[m,n] = size(pattern);
new = zeros(m,n);
total = matSum(pattern);
for i=1:m
    for j=1:n
        new(i,j)=pattern(i,j)/total;
    end
end
end