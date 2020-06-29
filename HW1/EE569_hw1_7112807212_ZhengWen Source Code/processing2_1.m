% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

clc;
clear all;
G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_noisy.raw');
G_ori = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Corn_gray.raw');

noiseDistPlot(G_ori, G);
noise_average = noiseAvg(matSub(G_ori, G));
noise_variance = noiseVar(matSub(G_ori, G));
noise_std = ceil(sqrt(noise_variance));    %  22.948, fix to 23 
G = raw22D(G, 320, 320);
G = matTranspose(G);
G_ori = raw22D(G_ori, 320, 320);
G_ori = matTranspose(G_ori);

G_uint8 = uint8(G);
imshow(G_uint8);
[m,n] = size(G);
standard_D = [0.5, 1, 5, 10, noise_std];
rP = [1,2,3,4,5];
count=1;

form_PSNR_Basic = zeros(length(rP), 1);

for i=1:length(rP)
    
    new_G = Basic(G,rP(1,i),1,0);
    [PSNRCal(new_G,G_ori) rP(1,i) 0]
    fig=figure(count);
    str1 = "r:";
    str2 = "PSNR:";
    TITLE=sprintf('%s %2.1f %s  %2.3f',str1,rP(i),str2,PSNRCal(new_G,G_ori));
    new_G_uint8 = uint8(new_G);
    imshow(new_G_uint8);
    title(TITLE);
    count=count+1;
    
    FILE_NAME = sprintf('%2.0f.tif',count-1);
    saveas(fig, FILE_NAME);
    
    form_PSNR_Basic(i,1) = PSNRCal(new_G,G_ori);

    
end

form_PSNR_GaussBasic = zeros(length(standard_D), length(rP));

for i=1:length(standard_D)
    for j=1:length(rP)
        new_G = Basic(G,rP(1,j),2,standard_D(1,i));
        str1 = "\sigma:";
        str2 = "r:";
        str3 = "PSNR:";
        TITLE=sprintf('%s %2.1f %s %2.1f %s  %2.3f',str1,standard_D(i),str2,rP(j),str3,PSNRCal(new_G,G_ori));
    
        fig=figure(count);
        
        new_G_uint8 = uint8(new_G);
        imshow(new_G_uint8);
        title(TITLE);
        count=count+1;
        
        FILE_NAME = sprintf('%2.0f.tif',count-1);
        saveas(fig, FILE_NAME);
        
        form_PSNR_GaussBasic(i,j) = PSNRCal(new_G,G_ori);
    end
end