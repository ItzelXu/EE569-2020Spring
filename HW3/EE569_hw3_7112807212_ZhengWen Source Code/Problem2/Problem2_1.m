% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

addpath('E:\Chrome Download\EE569\Week3\basicOperations');

% raw_fan = readraw('fan.raw');
% img = raw22D(raw_fan, 558, 558);
% raw = readraw('cup.raw');
% img = raw22D(raw, 315, 356);
raw = readraw('maze.raw');
img = raw22D(raw, 558, 558);
img = matTranspose(img);
img = fixedThresholdDithering(img, 50);
img_cp = img;
%% shrinking
% imshow(img);
count = 0;
img_prev = zeros(size(img));
while matSum(img_prev) ~= matSum(img)
%     if count == 15
%         break
%     end
    if count == 30
        break
    end
    char_img = img2charof_1(img);
    bond = calBondof_1(img);
    double_pre_char = char2double(char_img);
    cond_S = conditional_S(bond, double_pre_char);
    delete_if_1 = Unconditional_ST(cond_S);
    
    img_prev = img;
    
    img = step_delete(img, delete_if_1);
    count = count + 1;
end
imshow(img);

%% thinning
% count = 0;
% img_prev = zeros(size(img));
% while matSum(img_prev) ~= matSum(img)
% %     if count == 15
% %         break
% %     end
%     if count == 30
%         break
%     end
%     char_img = img2charof_1(img);
%     bond = calBondof_1(img);
%     double_pre_char = char2double(char_img);
%     cond_T = conditional_T(bond, double_pre_char);
%     delete_if_1 = Unconditional_ST(cond_T);
%     
%     img_prev = img;
%     
%     img = step_delete(img, delete_if_1);
%     count = count + 1;
% end
% imshow(img);

%% skeletonize
% count = 0;
% img_prev = zeros(size(img));
% while matSum(img_prev) ~= matSum(img)
% %     if count == 15
% %         break
% %     end
%     if count == 30
%         break
%     end
%     char_img = img2charof_1(img);
%     bond = calBondof_1(img);
%     double_pre_char = char2double(char_img);
%     cond_K = conditional_K(bond, double_pre_char);
%     delete_if_1 = Unconditional_K(cond_K);
%     
%     img_prev = img;
%     
%     img = step_delete(img, delete_if_1);
%     count = count + 1;
% end
% imshow(img);