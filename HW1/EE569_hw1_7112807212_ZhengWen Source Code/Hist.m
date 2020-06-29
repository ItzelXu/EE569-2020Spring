% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function res_img = Hist(img, m, n, transFunction)
res_img=zeros(m,n);
for i=1:m
    for j=1:n
        res_img(i,j)=transFunction(img(i,j)+1)-1;
    end    
end
end