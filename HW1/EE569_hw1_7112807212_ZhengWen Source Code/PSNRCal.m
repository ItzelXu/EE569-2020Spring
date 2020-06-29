% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function PSNR = PSNRCal(img1, img2)
[m,n]=size(img1);
MSE = (1/(m*n))*matSum(matDotMul(matSub(img1,img2),matSub(img1,img2)));
PSNR = 10*log10(255*255/MSE);
end