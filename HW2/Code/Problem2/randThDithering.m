% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = randThDithering(img)
    
[m,n] = size(img);
res = zeros(m,n);
for i = 1:m
    for j = 1:n
        rand_th = randi([0,255]);
        if img(i,j) < rand_th
            res(i,j) = 0;
        else
            res(i,j) = 255;
        end
    end
end
end