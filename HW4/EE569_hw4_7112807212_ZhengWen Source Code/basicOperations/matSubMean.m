% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = matSubMean(img)

[m, n] = size(img);
res = zeros(m,n);
mean = 0;
for i=1:m
    for j=1:n
        mean = mean + img(i,j);
    end
end

mean = mean / (m * n);

for i=1:m
    for j=1:n
        res(i,j) = img(i,j) - mean;
    end
end
end