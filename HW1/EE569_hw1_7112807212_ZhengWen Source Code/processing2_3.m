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

sizeL = [2,3,4];
sizeS = [1,2,3];
H = [50,100];
count=1;

for i=1:length(sizeL)
    for j=1:length(sizeS)
        
        if sizeL(i) <= sizeS(j)
            continue;
        end
        
        for k=1:length(H)
            new_G = NLmeans(G,sizeS(j),sizeL(i),H(k),30);
            fig = figure(count);
            new_G_uint8 = uint8(new_G);
            imshow(new_G_uint8);
            [PSNRCal(new_G,G_ori) sizeL(i) sizeS(j) H(k)]
            
            str1 = "LW:";
            str2 = "SW:";
            str3 = "H:";
            str4 = "PSNR:";
            
            TITLE=sprintf('%s %2.0f %s %2.0f %s %2.1f %s %2.3f',str1,sizeL(i),str2,sizeS(j),str3,H(k),str4,PSNRCal(new_G,G_ori));
            count = count + 1;
            title(TITLE);
            FILE_NAME = sprintf('%2.0f.tif',count-1);
            saveas(fig, FILE_NAME);
        end
    end
end