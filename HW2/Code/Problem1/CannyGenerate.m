% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

img = imread('E:\Chrome Download\EE569\Week2\HW2\Problem1\Gallery.jpg');
img = rgb2gray(img);

% for Dogs.jpg
% low_th = 0.1:0.01:0.5;
% high_th = 0.4:0.01:0.7;

% for Gallery.jpg
low_th = 0.1:0.01:0.3;
high_th = 0.4:0.01:0.6;

img_count = 0;
canny = zeros(size(img));
for i=1:length(low_th)
    for j=1:length(high_th)
        if low_th(i) < high_th(j) - 0.2
            canny = canny + edge(img, 'Canny', [low_th(i), high_th(j)]);
            img_count = img_count + 1;
        end
    end
end
canny = canny / img_count;
canny = 1 - canny;

imwrite(canny, 'Gallery_Canny.tif')
imshow(canny)