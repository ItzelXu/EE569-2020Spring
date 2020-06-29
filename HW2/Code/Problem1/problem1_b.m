% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

img = imread('E:\Chrome Download\EE569\Week2\HW2\Problem1\Dogs.jpg');
img = rgb2gray(img);
low_th = [0.1, 0.15, 0.2, 0.3, 0.35, 0.4];
high_th = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
img_count = 1;
for i=1:length(low_th)
    for j=1:length(high_th)
        if low_th(i) < high_th(j)
            canny = 1 - edge(img, 'Canny', [low_th(i), high_th(j)]); %%1:2, 1:3
            fig = figure(img_count);
            
            imshow(canny, 'border','tight','initialmagnification','fit');
            TITLE = sprintf('ht=%.2f lt=%.2f.tif',high_th(j), low_th(i));
            %saveas(fig, TITLE);
            img_count = img_count + 1;
            if high_th(j) == 0.3 && low_th(i) == 0.2
                TITLE
                imwrite(canny, TITLE);
            end
        end
    end
end
