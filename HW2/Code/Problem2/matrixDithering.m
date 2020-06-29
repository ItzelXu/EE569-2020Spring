% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function [img_2, img_8, img_32] = matrixDithering(img)

[m,n] = size(img);
I_2 = [1, 2; 3, 0];
I_4 = Ipadd(I_2);
I_8 = Ipadd(I_4);
I_16 = Ipadd(I_8);
I_32 = Ipadd(I_16);

T_2 = Tgen(I_2);
T_8 = Tgen(I_8);
T_32 = Tgen(I_32);

img_2 = zeros(m,n);
img_8 = zeros(m,n);
img_32 = zeros(m,n);

for i = 1:m
    for j = 1:n
        
        if img(i,j) <= T_2(mod(i-1,2)+1,mod(j-1,2)+1)
            img_2(i,j) = 0;
        else
            img_2(i,j) = 255;
        end
        
        if img(i,j) <= T_8(mod(i-1,8)+1,mod(j-1,8)+1)
            img_8(i,j) = 0;
        else
            img_8(i,j) = 255;
        end
        
        if img(i,j) <= T_32(mod(i-1,32)+1,mod(j-1,32)+1)
            img_32(i,j) = 0;
        else
            img_32(i,j) = 255;
        end
    end
end
    
end