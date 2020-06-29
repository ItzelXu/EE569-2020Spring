% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function frequency = HisCount(img,m,n)
frequency=zeros(1,256);
for i=1:m
    for j=1:n
        frequency(1,img(i,j)+1)=frequency(1,img(i,j)+1)+1;
    end    
end
end