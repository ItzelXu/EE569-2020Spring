% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function pixelArray = Arrange(img,m,n)
index=1;
for pixel=0:255
    for i=1:m
        for j=1:n
            if img(i,j)==pixel
                pixelArray(index).m=i;
                pixelArray(index).n=j;
                index=index+1;
            end
        end
    end
end
end