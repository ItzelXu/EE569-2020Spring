% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

% count: shrink several iter and count # of M. 
% center should be recorded in preparation for next problem.
% path:  reverse, shrink, count white until unchanged, shrink, count M with
% others = 0, destory circle with center in count,
% shrink 100000 continue count M, 1st stable is circle, then the number of path, 
% to stable. both white and M do not change, In the end, res + 1 for
% assuming the outside is connected. 
% generally delete left if UL, L, DL not connected, else, delete up, 
% else right.


raw = readraw('PCB.raw');
img = raw22D(raw, 372, 239);
img = img';
img = fixedThresholdDithering(img, 60);
img_cp = img;
[m,n]=size(img);
img(:,1) = 0;
img(:,n) = 0;
img(1,:) = 0;
img(m,:) = 0;
figure(1);
imshow(img);
imwrite(img, 'PCB_ori.tif')
img_rev = ImgInverse_1(img);
figure(2);
imshow(img_rev);
imwrite(img_rev, 'PCB_inv.tif')
%% count the num of hole
img_point = bwmorph(img, 'shrink', Inf);
figure(3);
imshow(img_point);
imwrite(img_point, 'PCB_hole_sol.tif')
[num_alone, pos] = countAlone(img_point);
fprintf("number of hole is %d\n", num_alone);
%% # of path
img_path = bwmorph(img_rev, 'shrink', Inf);
figure(4);
imshow(img_path);
imwrite(img_path, 'PCB_inv_path_shrink.tif')
[num_pos, ~] = size(pos);
% destory connectivity from center to surrounding
for i=1:num_pos
    ori_i = pos(i, 1);
    ori_j = pos(i, 2);
    
    % up
    find_i = ori_i;
    while img_path(find_i, ori_j) == 0
        find_i = find_i + 1;
    end
    if countBondforSinglePoint(img_path, find_i, ori_j) == 2
        img_path(find_i, ori_j) = 0;
        continue
    end
    % down
    find_i = ori_i;
    while img_path(find_i, ori_j) == 0
        find_i = find_i - 1;
    end
    if countBondforSinglePoint(img_path, find_i, ori_j) == 2
        img_path(find_i, ori_j) = 0;
        continue
    end
    % left
    find_j = ori_j;
    while img_path(ori_i, find_j) == 0
        find_j = find_j - 1;
    end
    if countBondforSinglePoint(img_path, ori_i, find_j) == 2
        img_path(ori_i, find_j) = 0;
        continue
    end
    % right
    find_j = ori_j;
    while img_path(ori_i, find_j) == 0
        find_j = find_j + 1;
    end
    if countBondforSinglePoint(img_path, ori_i, find_j) == 2
        img_path(ori_i, find_j) = 0;
        continue
    end

end
figure(5);
imshow(img_path);
imwrite(img_path, 'PCB_inv_path_shrink_break.tif')
% count # of path
img_path_shrink = img_path;
img_path_shrink_pre = zeros(size(img_path));
num_alone = [];
count = 0;
while matSum(img_path_shrink) ~= matSum(img_path_shrink_pre)
    img_path_shrink_pre = img_path_shrink;
    img_path_shrink = bwmorph(img_path_shrink, 'shrink', 1);
    num_alone(end + 1) = countAlone(img_path_shrink);
    count = count + 1;
    if count == 8
        figure(6);
        imshow(img_path_shrink)
        imwrite(img_path_shrink, 'PCB_inv_path_shrink_no_hole.tif')
        number_hole = num_alone(end);

    end
end
figure(7);
imshow(img_path_shrink)
imwrite(img_path_shrink, 'PCB_inv_path_shrink_final.tif')

num_path_ring = num_alone(end);
for i = length(num_alone): -1: 1
    if num_alone(i) ~= num_path_ring
        i_adundant = i;
        break
    end
end
num_alone = num_alone(1:i_adundant + 15);
f8 = figure(8);
plot(num_alone);
xlabel("iteration")
ylabel('number of alone pixels')
saveas(f8, 'num_alone_pix_path.tif')

number_path = num_path_ring - number_hole;
fprintf("number of path is %d\n", number_path);