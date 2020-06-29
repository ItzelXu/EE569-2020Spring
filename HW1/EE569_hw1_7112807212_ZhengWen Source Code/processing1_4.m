% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

clear all
clc

G = readraw('E:\Chrome Download\EE569\Week1\HW1_images\Toy.raw');

[G_Red, G_Green, G_Blue] = raw23D(G,400,560);
G_Red = matTranspose(G_Red);
G_Green = matTranspose(G_Green);
G_Blue = matTranspose(G_Blue);

G=zeros(560,400,3);
G(:,:,1)=G_Red;
G(:,:,2)=G_Green;
G(:,:,3)=G_Blue;

figure(10);
imshow(uint8(G));

[m,n]=size(G_Red);

frequency_Red = HisCount(G_Red,m,n);
frequency_Green = HisCount(G_Green,m,n);
frequency_Blue = HisCount(G_Blue,m,n);

sum_Red = TotalSum(frequency_Red);
sum_Green = TotalSum(frequency_Green);
sum_Blue = TotalSum(frequency_Blue);

pixelArrayRed = Arrange(G_Red, m, n);
pixelArrayGreen = Arrange(G_Green, m, n);
pixelArrayBlue = Arrange(G_Blue, m, n);

pixelArrayRedRand = randomize(pixelArrayRed, frequency_Red, sum_Red);
pixelArrayGreenRand = randomize(pixelArrayGreen, frequency_Green, sum_Green);
pixelArrayBlueRand = randomize(pixelArrayBlue, frequency_Blue, sum_Blue);

G_Red_Re = reconstruct(pixelArrayRed,m,n);
G_Green_Re = reconstruct(pixelArrayGreen,m,n);
G_Blue_Re = reconstruct(pixelArrayBlue,m,n);

G_Re=zeros(m,n,3);
G_Re(:,:,1)=G_Red_Re;
G_Re(:,:,2)=G_Green_Re;
G_Re(:,:,3)=G_Blue_Re;

frequency_Red_After = HisCount(G_Red_Re,m,n);
frequency_Green_After = HisCount(G_Green_Re,m,n);
frequency_Blue_After = HisCount(G_Blue_Re,m,n);
figure(11);
imshow(uint8(G_Re));
figure(6);
bar(frequency_Red_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Red (Method 2)");
figure(7);
bar(frequency_Green_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Green (Method 2)");
figure(8);
bar(frequency_Blue_After);
xlabel("Pixels");
ylabel("Number");
title("Processed Histogram - Blue (Method 2)");

sum_Red_After = TotalSum(frequency_Red_After);
sum_Green_After = TotalSum(frequency_Green_After);
sum_Blue_After = TotalSum(frequency_Blue_After);
figure(1);
bar(sum_Red_After);
xlabel("Pixels");
ylabel("Number");
title("Cumulative Histogram - Red (Method 2)");
figure(2);
bar(sum_Green_After);
xlabel("Pixels");
ylabel("Number");
title("Cumulative Histogram - Green (Method 2)");
figure(3);
bar(sum_Blue_After);
xlabel("Pixels");
ylabel("Number");
title("Cumulative Histogram - Blue (Method 2)");
%frequency_Red = HisCount(G_Re(:,:,1),m,n);
%plot(frequency_Red);






