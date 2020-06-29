% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function newImg = reconstruct(pixelArray,m,n)

newImg=zeros(m,n);
len=length(pixelArray);
factor=len/256;
left=zeros(1,256);
right=zeros(1,256);

for i=1:256
    if i==1
        left(1,i)=1;
    else
        left(1,i)=round((i-1)*factor)+1;
    end
    
    if i==256
        right(1,i)=len;
    else
        right(1,i)=round(i*factor);
    end
end

for i=1:256
    for j=left(1,i):right(1,i)
        newImg(pixelArray(1,j).m, pixelArray(1,j).n)=i-1;
    end
end
end