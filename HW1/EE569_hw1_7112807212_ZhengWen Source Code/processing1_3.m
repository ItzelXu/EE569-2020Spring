% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020
clc
clear all;
G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Toy.raw');
[G_Red, G_Green, G_Blue] = raw23D(G,400,560);
G_Red = matTranspose(G_Red);
G_Green = matTranspose(G_Green);
G_Blue = matTranspose(G_Blue);

G=zeros(560,400,3);
G(:,:,1)=G_Red;
G(:,:,2)=G_Green;
G(:,:,3)=G_Blue;

figure(1);
imshow(uint8(G));

[m,n]=size(G_Red);

frequency_Red = HisCount(G_Red,m,n);
frequency_Green = HisCount(G_Green,m,n);
frequency_Blue = HisCount(G_Blue,m,n);
figure(2);
bar(frequency_Red);
xlabel("Pixels");
ylabel("Number");
title("Original Histogram - Red");
figure(3);
bar(frequency_Green);
xlabel("Pixels");
ylabel("Number");
title("Original Histogram - Green");
figure(4);
bar(frequency_Blue);
xlabel("Pixels");
ylabel("Number");
title("Original Histogram - Blue");

sum_Red = round(256*TotalSum(frequency_Red)/(m*n));
sum_Green = round(256*TotalSum(frequency_Green)/(m*n));
sum_Blue = round(256*TotalSum(frequency_Blue)/(m*n));
figure(5);
plot(sum_Red);
xlabel("Original Pixels");
ylabel("Projected Pixels");
title("Transfer Function - Red");
figure(6);
plot(sum_Green);
xlabel("Original Pixels");
ylabel("Projected Pixels");
title("Transfer Function - Green");
figure(7);
plot(sum_Blue);
xlabel("Original Pixels");
ylabel("Projected Pixels");
title("Transfer Function - Blue");


G_Red_After = Hist(G_Red,m,n,sum_Red);
G_Green_After = Hist(G_Green,m,n, sum_Green);
G_Blue_After = Hist(G_Blue,m,n, sum_Blue);


%imshow(uint8(G_Red_After));

G_After = zeros(m,n,3);
G_After(:,:,1)=G_Red_After;
G_After(:,:,2)=G_Green_After;
G_After(:,:,3)=G_Blue_After;

figure(8)
imshow(uint8(G_After))

frequency_Red_After = HisCount(G_Red_After,m,n);
frequency_Green_After = HisCount(G_Green_After,m,n);
frequency_Blue_After = HisCount(G_Blue_After,m,n);
figure(9);
bar(frequency_Red_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Red (Method 1)");
figure(10);
bar(frequency_Green_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Green (Method 1)");
figure(11);
bar(frequency_Blue_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Blue (Method 1)");