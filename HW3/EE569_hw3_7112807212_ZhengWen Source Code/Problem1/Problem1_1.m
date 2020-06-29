% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

raw_hedwig = readraw('hedwig.raw');
ori_hedwig = raw2img3(raw_hedwig, 512, 512);
imwrite(uint8(ori_hedwig), 'ori_hedwig.tif');
res_hedwig = warping_from_raw(raw_hedwig);
figure(1)
imshow(uint8(res_hedwig))
imwrite(uint8(res_hedwig), 'sol_hedwig.tif')
unwarping_hedwig = unwarping_from_circle(res_hedwig);
figure(2)
imshow(uint8(unwarping_hedwig))
imwrite(uint8(unwarping_hedwig), 'sol_hedwig_un.tif')

raw_raccoon = readraw('raccoon.raw');
ori_raccoon = raw2img3(raw_raccoon, 512, 512);
imwrite(uint8(ori_raccoon), 'ori_raccoon.tif');
res_raccoon = warping_from_raw(raw_raccoon);
figure(3)
imshow(uint8(res_raccoon))
imwrite(uint8(res_raccoon), 'sol_raccoon.tif')
unwarping_raccoon = unwarping_from_circle(res_raccoon);
figure(4)
imshow(uint8(unwarping_raccoon))
imwrite(uint8(unwarping_raccoon), 'sol_raccoon_un.tif')

raw_bb8 = readraw('bb8.raw');
ori_bb8 = raw2img3(raw_bb8, 512, 512);
imwrite(uint8(ori_bb8), 'ori_bb8.tif');
res_bb8 = warping_from_raw(raw_bb8);
figure(5)
imshow(uint8(res_bb8))
imwrite(uint8(res_bb8), 'sol_bb8.tif')
unwarping_bb8 = unwarping_from_circle(res_bb8);
figure(6)
imshow(uint8(unwarping_bb8))
imwrite(uint8(unwarping_bb8), 'sol_bb8_un.tif')