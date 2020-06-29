% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function res = matFlip(img, axis)
[m,n] = size(img);
res = zeros(m,n);
if axis == 1
    for i=1:m
        for j=1:n
            res(i,j) = img(m - i + 1, j);
        end
    end
else
    for i=1:m
        for j=1:n
            res(i,j) = img(i, n - j + 1);
        end
    end
end

end