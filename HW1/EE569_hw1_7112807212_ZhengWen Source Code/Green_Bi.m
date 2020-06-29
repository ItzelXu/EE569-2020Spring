% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function GreenLayer = Green_Bi(img, m, n)
    GreenLayer = zeros(m, n);
    for i = 1:m
        for j = 1:n
            if (mod(i,2) == 1 && mod(j,2) == 1) || (mod(i,2) == 0 && mod(j,2) == 0)
                GreenLayer(i,j) = img(i,j);
            else
                GreenLayer(i,j) = round(1/4*(img(be_m(i-1,m),j)+img(i,be_m(j-1,n))+img(be_m(i+1,m),j)+img(i,be_m(j+1,n))));
            end
        end
    end
end