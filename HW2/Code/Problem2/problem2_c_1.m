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

C = RGB2CMY(R);
M = RGB2CMY(G);
Y = RGB2CMY(B);

FS = (1/16)*[0 0 0; 0 0 7; 3 5 1];
FS_re =(1/16)*[0 0 0; 7 0 0; 1 5 3];

C_FS =  errorDiffusion(C, FS, FS_re);
M_FS = errorDiffusion(M, FS, FS_re);
Y_FS = errorDiffusion(Y, FS, FS_re);

figure();
imshow(C_FS);

figure();
imshow(M_FS);

figure();
imshow(Y_FS);

[m,n] = size(C_FS);
img_res = zeros(m,n,3);

img_res(:,:,1)=RGB2CMY(C_FS);
img_res(:,:,2)=RGB2CMY(M_FS);
img_res(:,:,3)=RGB2CMY(Y_FS);

imwrite(img_res, 'color_FS.tif')
figure();
imshow(img_res);
