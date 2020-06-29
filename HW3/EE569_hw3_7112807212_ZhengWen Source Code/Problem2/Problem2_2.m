% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

raw = readraw('stars.raw');
img = raw22D(raw, 640, 480);
img = matTranspose(img);
img = fixedThresholdDithering(img, 150);
img_raw = img;
figure(1)
imshow(img);
imwrite(img, 'star_ori.tif')
img_shrinked = bwmorph(img, 'shrink', Inf);
figure(2)
imshow(img_shrinked);
imwrite(img_shrinked, 'star_shrinked.tif')
[m, n] = size(img);
num_stars = countAlone(img_shrinked);
img_cp = img;


each_area = [];
each_dis = [];

for i=1:m
    for j=1:n
        if img_shrinked(i, j)
            stack = [i,j];
            i_max = i;
            i_min = i;
            j_max = j;
            j_min = j;
            img(i, j) = 0;
            count = 0;
            while stack
                a = stack(end, 1);
                b = stack(end, 2);
                if a > i_max
                    i_max = a;
                end
                if a < i_min
                    i_min = a;
                end
                if b > j_max
                    j_max = b;
                end
                if b < j_min
                    j_min = b;
                end
                stack(end, :) = [];
                count = count + 1;
%                 if a - 1 >= 1 && b - 1 >= 1 && img(a - 1, b - 1)
%                     stack(end + 1, :) = [a - 1, b - 1];
%                     img(a - 1, b - 1) = 0;
%                 end
                if a - 1 >= 1 && img(a - 1, b)
                    stack(end + 1, :) = [a - 1, b];
                    img(a - 1, b) = 0;
                end
%                 if a - 1 >= 1 && b + 1 <= n && img(a - 1, b + 1)
%                     stack(end + 1, :) = [a - 1, b + 1];
%                     img(a - 1, b + 1) = 0;
%                 end
                if b - 1 >= 1 && img(a, b - 1)
                    stack(end + 1, :) = [a, b - 1];
                    img(a, b - 1) = 0;
                end
                if b + 1 <= n && img(a, b + 1)
                    stack(end + 1, :) = [a, b + 1];
                    img(a, b + 1) = 0;
                end
%                 if a + 1 <= m && b - 1 >= 1 && img(a + 1, b - 1)
%                     stack(end + 1, :) = [a + 1, b - 1];
%                     img(a + 1, b - 1) = 0;
%                 end
                if a + 1 <= m && img(a + 1, b)
                    stack(end + 1, :) = [a + 1, b];
                    img(a + 1, b) = 0;
                end
%                 if a + 1 <= m && b + 1 <= n && img(a + 1, b + 1)
%                     stack(end + 1, :) = [a + 1, b + 1];
%                     img(a + 1, b + 1) = 0;
%                 end
            end
            each_area(end + 1) = count;
            each_dis(end + 1) = max(i_max - i_min, j_max - j_min);
        end
    end
end

num_area = zeros(1, max(each_area));
m = length(each_area);
for i = 1:m
    num_area(each_area(i)) = num_area(each_area(i)) + 1;
end
f3 = figure(3);
bar(num_area)
xlabel('area in number of pixels');
ylabel('number of star');
saveas(f3, 'star_num_area.tif')
num_dist = zeros(1, max(each_dis));
m = length(each_dis);
for i = 1:m
    num_dist(each_dis(i)) = num_dist(each_dis(i)) + 1;
end
f4 = figure(4);
bar(num_dist)
xlabel('area in distance');
ylabel('number of star');
saveas(f4, 'star_num_dist.tif')

%%
img = img_raw;
cumu = [];
img_prev = zeros(size(img));
while matSum(img_prev) ~= matSum(img)
    cumu(end + 1) = countAlone(img);
    img_prev = img;
    img = bwmorph(img, 'shrink', 1);
end
for i = 1:length(cumu) - 1
    star_size_1(i) = cumu(i + 1) - cumu(i);
end
f5 = figure(5);
bar(star_size_1)
xlabel('star size by shrink');
ylabel('number of star');
saveas(f5, 'star_num_shrink.tif')

