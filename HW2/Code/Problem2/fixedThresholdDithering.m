% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = fixedThresholdDithering(img,threshold)

[m,n] = size(img);
res = zeros(m,n);
for i=1:m
    for j=1:n
        if img(i,j)>threshold
            res(i,j) = 255;
        else
            res(i,j) = 0;
        end
    end
end
end