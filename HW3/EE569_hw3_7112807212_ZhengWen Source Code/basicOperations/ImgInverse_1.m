% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function InversedImg = ImgInverse_1(img)

[m,n] = size(img);
InversedImg = zeros(m,n);
for i=1:m
    for j=1:n
        InversedImg(i,j) = 1 - img(i,j);
    end
end

end