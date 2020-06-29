% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

clc
clear all

m = 200;
n = 200;

sigma = 15;

G = zeros(m, n);
for i=1:m
    for j=1:n
        G(i,j) = 128;
    end
end

G_ori = G;

fig = figure(1);
imshow(uint8(G));
FILE_NAME = sprintf('%2.0f.tif',1);
saveas(fig, FILE_NAME);

for i=1:m
    for j=1:n
        flag = rand(1);
        if flag < 0.1
            G(i,j) = 0;
        elseif flag > 0.9
            G(i,j) = 255;
        end
    end
end

fig = figure(2);
imshow(uint8(G));
FILE_NAME = sprintf('%2.0f.tif',2);
saveas(fig, FILE_NAME);

for i=1:m
    for j=1:n
        G(i,j) = G(i,j) + sigma*randn(1,1);
    end
end

fig = figure(3);
imshow(uint8(G));
FILE_NAME = sprintf('%2.0f.tif',3);
saveas(fig, FILE_NAME);

G_right = outlier(G, 30);
G_right = Basic(G_right, 3, 1, 0);
PSNR_R = PSNRCal(G_ori, G_right);


fig = figure(4);
imshow(uint8(G_right));
FILE_NAME = sprintf('%2.0f.tif',4);
saveas(fig, FILE_NAME);

G_wrong = Basic(G, 3, 1, 0);
G_wrong = outlier(G_wrong, 30);

fig = figure(5);
imshow(uint8(G_wrong));
PSNR_W = PSNRCal(G_ori, G_wrong);
FILE_NAME = sprintf('%2.0f.tif',5);
saveas(fig, FILE_NAME);

