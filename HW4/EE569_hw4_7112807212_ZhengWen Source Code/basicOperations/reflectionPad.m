% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function paddedImg = reflectionPad(img,radius)
[m,n]=size(img);
paddedImg=zeros(m+2*radius,n+2*radius);
paddedImg(radius+1:m+radius, radius+1:n+radius)=img;
for i=1:radius
    paddedImg(:,radius-i+1) = paddedImg(:,radius+i);
    paddedImg(:,n+radius+i) = paddedImg(:,n+radius-i+1);
end

for i=1:radius
    paddedImg(radius-i+1,:) = paddedImg(radius+i,:);
    paddedImg(m+radius+i,:) = paddedImg(m+radius-i+1,:);
end
end