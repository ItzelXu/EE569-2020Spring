% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function res = outlier(img, threshold)

[m,n] = size(img);


for i =1:m
    for j=1:n
        avg = (1/8)*(img(be_m(i-1,m),be_m(j-1,n))+img(be_m(i,m),be_m(j-1,n))+img(be_m(i+1,m),be_m(j-1,n))+...
                     img(be_m(i-1,m),be_m(j,n))+img(be_m(i+1,m),be_m(j,n))+...
                     img(be_m(i-1,m),be_m(j+1,n))+img(be_m(i,m),be_m(j+1,n))+img(be_m(i+1,m),be_m(j+1,n)));
        if abs(img(i,j) - avg) > threshold
            img(i,j) = avg;
        end
    end
end

res = img;
end

