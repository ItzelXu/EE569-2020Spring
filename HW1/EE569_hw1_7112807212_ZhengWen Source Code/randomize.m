% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function randomPA = randomize(pixelArray, frequency, sumArray)
for i=1:256
    sub_index=randperm(frequency(1,i));
    if i==1
        head=1;
    else
        head=sumArray(1,i-1)+1;
    end
    temp=pixelArray(1,head:sumArray(1,i));
    temp=temp(1,sub_index);
    pixelArray(1,head:sumArray(1,i))=temp;
end
randomPA=pixelArray;
end