% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

addpath('basicOperations')

img = readraw('E:\Chrome Download\EE569\Week2\HW2\Problem1\Gallery.raw');
[R, G, B] = raw23D(img, 481, 321);
R = matTranspose(R);
G = matTranspose(G);
B = matTranspose(B);
gray = RGB2Gray(R,G,B);
[sobel_x, sobel_y, sobel_final] = sobel(gray);

sobel_x = gradNorm(sobel_x);
sobel_y = gradNorm(sobel_y);
sobel_final = gradNorm(sobel_final);

img_count = 1;
fig = figure(img_count);
imshow(uint8(sobel_x), 'border','tight','initialmagnification','fit');
% title("Dogs.raw X Gradient");
img_count = img_count + 1;
FILENAME = sprintf('%.0f.tif', img_count-1);
saveas(fig, FILENAME)

fig = figure(img_count);
imshow(uint8(sobel_y), 'border','tight','initialmagnification','fit');
% title("Dogs.raw Y Gradient");
img_count = img_count + 1;
FILENAME = sprintf('%.0f.tif', img_count-1);
saveas(fig, FILENAME)


fig = figure(img_count);
imshow(uint8(sobel_final), 'border','tight','initialmagnification','fit');
% title("Dogs.raw Gradient Magnitude");
img_count = img_count + 1;
FILENAME = sprintf('%.0f.tif', img_count-1);
imwrite(im2double(uint8(sobel_final)), 'Dogs_Sobel.tif')
threshold = [0.99, 0.98, 0.97, 0.96, 0.95, 0.94, 0.93, 0.92, 0.91, 0.9];

for i=1:length(threshold)
    fig = figure(img_count);
    sobel_binarized = binarize(double(uint8(sobel_final)), threshold(i));
    sobel_binarized = constMatSub(255, sobel_binarized);
    imshow(uint8(sobel_binarized), 'border','tight','initialmagnification','fit');
    TITLE = sprintf("Th = %1.2f", threshold(i));
%     title(TITLE);
    img_count = img_count + 1;
    FILENAME = sprintf('%.0f.tif', img_count-1);
    imwrite(sobel_binarized, FILENAME)
end
