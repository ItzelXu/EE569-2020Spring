% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations');

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem2\Rose.raw');
[R, G, B] = raw23D(img, 640, 480);
R = im2double(uint8(matTranspose(R)));
G = im2double(uint8(matTranspose(G)));
B = im2double(uint8(matTranspose(B)));

img_show(:,:,1)=R;
img_show(:,:,2)=G;
img_show(:,:,3)=B;
imshow(img_show)

FS = (1/16)*[0 0 0; 0 0 7; 3 5 1];
FS_re =(1/16)*[0 0 0; 7 0 0; 1 5 3];

img_res =  MBVQ(R, G, B, FS, FS_re);

figure();
imshow(img_res);

imwrite(img_res, 'color_MBVQ.tif')

