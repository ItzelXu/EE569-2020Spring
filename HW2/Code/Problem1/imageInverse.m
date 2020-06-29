% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function res = imageInverse(img)

[m,n] = size(img);
res = zeros(m,n);
for i=1:m
    for j=1:n
        res(i,j) = 255-img(i,j);
    end
end

end