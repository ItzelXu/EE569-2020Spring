% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function paddedImg = zeroPad(img,radius)
[m,n]=size(img);
paddedImg=zeros(m+2*radius,n+2*radius);
paddedImg(radius+1:m+radius, radius+1:n+radius)=img;
end