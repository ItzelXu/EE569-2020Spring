% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function res = TotalSum(array)
m=length(array);
sum=0;
res=zeros(1,m);
for i=1:m
    sum=sum+array(1,i);
    res(1,i)=sum;
end
end