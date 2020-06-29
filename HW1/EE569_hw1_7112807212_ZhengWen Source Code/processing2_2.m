% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

clc;
clear all;
G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_noisy.raw');
G_ori = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_gray.raw');
G = raw22D(G, 320, 320);
G = matTranspose(G);
G_ori = raw22D(G_ori, 320, 320);
G_ori = matTranspose(G_ori);

G_uint8 = uint8(G);
% imshow(G_uint8);
standard_C = [0.5,1,5];
standard_S = [10,50,200,500];

count=1;

for i=1:length(standard_C)
    for j=1:length(standard_S)
        new_G = Bilaterial(G,2,standard_C(1,i),standard_S(1,j));
        [PSNRCal(new_G,G_ori) standard_C(1,i) standard_S(1,j)]
        str1 = "sigmaC:";
        str2 = "sigmaS:";
        str3 = "PSNR";
        TITLE=sprintf('%s %2.1f %s %2.1f %s %2.3f',str1,standard_C(1,i),str2,standard_S(1,j),str3,PSNRCal(new_G,G_ori));
    
        fig = figure(count);
        
        new_G_uint8 = uint8(new_G);
        imshow(new_G_uint8);
        title(TITLE);
        count=count+1;
        FILE_NAME = sprintf('%2.0f.tif',count-1);
        %saveas(fig, FILE_NAME);
    end
end

