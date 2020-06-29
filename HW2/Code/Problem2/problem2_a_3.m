% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations');

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem2\LightHouse.raw');
img = raw22D(img, 750, 500);
img = matTranspose(img);

[img_D2, img_D8, img_D32] = matrixDithering(img);

figure(1);
imshow(uint8(img_D2));
title("Dithering by I2");
imwrite(uint8(img_D2), 'I2.tif')

figure(2);
imshow(uint8(img_D8));
title("Dithering by I8");
imwrite(uint8(img_D8), 'I8.tif')

figure(3);
imshow(uint8(img_D32));
title("Dithering by I32");
imwrite(uint8(img_D32), 'I32.tif')