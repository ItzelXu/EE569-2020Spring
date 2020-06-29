% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations');

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem2\LightHouse.raw');
img = raw22D(img, 750, 500);
img = matTranspose(img);

Th = [75, 100, 125, 150, 175, 200];
img_count = 1;
for i = 1:length(Th)
    fig = figure(img_count);
    img_Th = fixedThresholdDithering(img, Th(i));
    imshow(uint8(img_Th))
    img_count = img_count + 1;
    FILENAME = sprintf('%.0f.tif', img_count - 1);
    imwrite(uint8(img_Th), FILENAME)
end

