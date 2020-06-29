% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function [changed_img, new_img, mid_ul_I, mid_ul_J, loc_mat] = in2out_paro(img_left, H_left2mid, img_mid, feature_left_mean, feature_mid_mean, mode)


%% left
% left 2 gray
img_left_gray = rgb2gray(img_left);
img_left_R = img_left(:,:,1);
img_left_G = img_left(:,:,2);
img_left_B = img_left(:,:,3);

[m_left_ori,n_left_ori] = size(img_left_gray);
[J_ori_in_left, I_ori_in_left] = matMeshgrid(1:n_left_ori, 1:m_left_ori);
I_ori_left2mid = zeros(size(I_ori_in_left));
J_ori_left2mid = zeros(size(J_ori_in_left));
% change ori to (0,0)
I_ori_in_left = matAddConst(I_ori_in_left, -1);
J_ori_in_left = matAddConst(J_ori_in_left, -1);
% project ori_left to mid (mid with translation to (481, :))
for i=1:m_left_ori
    for j=1:n_left_ori
        point = matTranspose([J_ori_in_left(i,j), I_ori_in_left(i,j), 1]);  % feature_X -> J, feature_Y -> I
        point_out_prime = H_left2mid * point;
        J_ori_left2mid(i,j) = point_out_prime(1,1) / point_out_prime(3,1);
        I_ori_left2mid(i,j) = point_out_prime(2,1) / point_out_prime(3,1);
    end
end

% transfer the original to begin with the minimum value after projection of
% left 2 mid with mid supposed at (481, :)
I_new_trans_lm = min(min(I_ori_left2mid)); % transfer_left_L, added after processing to mid
J_new_trans_lm = min(min(J_ori_left2mid)); % transfer_left_R, added after processing to mid

I_ori_left2mid = I_ori_left2mid - I_new_trans_lm;
J_ori_left2mid = J_ori_left2mid - J_new_trans_lm;

I_ori_left2mid_max = ceil(max(max(I_ori_left2mid)));
J_ori_left2mid_max = ceil(max(max(J_ori_left2mid)));

left_out_R = zeros(I_ori_left2mid_max, J_ori_left2mid_max);
left_out_G = zeros(I_ori_left2mid_max, J_ori_left2mid_max);
left_out_B = zeros(I_ori_left2mid_max, J_ori_left2mid_max);
[m_out_left, n_out_left] = size(left_out_R);
[J_out_left, I_out_left] = matMeshgrid(1:n_out_left, 1:m_out_left);
H_left2mid_inv = inv(H_left2mid);
% cal the corresponding (x,y) in ori_left for the new img.
I_out_left_bk_ori_left = zeros(m_out_left, n_out_left);
J_out_left_bk_ori_left = zeros(m_out_left, n_out_left);

for i=1:m_out_left
    for j=1:n_out_left
        point = matTranspose([J_out_left(i,j) + J_new_trans_lm, I_out_left(i,j) + I_new_trans_lm, 1]);  % feature_X -> J, feature_Y -> I
        w2 = 1 / (H_left2mid_inv(3, 1) * point(1, 1) + H_left2mid_inv(3, 2) * point(2, 1) + H_left2mid_inv(3, 3) * point(3, 1));
        point_prime = w2 * point;
        point_in_ori = H_left2mid \ point_prime;
        J_out_left_bk_ori_left(i,j) = point_in_ori(1,1);
        I_out_left_bk_ori_left(i,j) = point_in_ori(2,1);
    end
end
% put ori in (1,1)
I_out_left_bk_ori_left = I_out_left_bk_ori_left + 1;
J_out_left_bk_ori_left = J_out_left_bk_ori_left + 1;
% interpolate

left_loc = zeros(m_out_left, n_out_left);

for i=1:m_out_left
    for j=1:n_out_left
%            [ceil(I_out_left_bk_ori_left(i,j)), ceil(J_out_left_bk_ori_left(i,j)), i, j]
        if (I_out_left_bk_ori_left(i,j) <= 1 || J_out_left_bk_ori_left(i,j) <= 1) &&...
                (I_out_left_bk_ori_left(i,j) > 0 && J_out_left_bk_ori_left(i,j) > 0 &&...
                ceil(I_out_left_bk_ori_left(i,j)) <= m_left_ori && ceil(J_out_left_bk_ori_left(i,j)) <= n_left_ori)
            left_out_R(i,j) = img_left_R(ceil(I_out_left_bk_ori_left(i,j)), ceil(J_out_left_bk_ori_left(i,j)));
            left_out_G(i,j) = img_left_G(ceil(I_out_left_bk_ori_left(i,j)), ceil(J_out_left_bk_ori_left(i,j)));
            left_out_B(i,j) = img_left_B(ceil(I_out_left_bk_ori_left(i,j)), ceil(J_out_left_bk_ori_left(i,j)));

            left_loc(i,j) = 1;
%             [ceil(I_ori(i,j)), ceil(J_ori(i,j)), i, j]
        elseif (fix(I_out_left_bk_ori_left(i,j)) + 1 <= m_left_ori &&...
                fix(J_out_left_bk_ori_left(i,j)) + 1 <= n_left_ori) &&...
                (I_out_left_bk_ori_left(i,j) > 0 && J_out_left_bk_ori_left(i,j) > 0 &&...
                I_out_left_bk_ori_left(i,j) <= m_left_ori && J_out_left_bk_ori_left(i,j) <= n_left_ori)
            div_I = I_out_left_bk_ori_left(i,j) - fix(I_out_left_bk_ori_left(i,j));
            div_J = J_out_left_bk_ori_left(i,j) - fix(J_out_left_bk_ori_left(i,j));
            left_out_R(i,j) = (1 - div_I) * (1 - div_J) * img_left_R(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j))) + ...
                           div_I * (1 - div_J) * img_left_R(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j))) + ...
                           (1 - div_I) * div_J * img_left_R(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j)) + 1) + ...
                           div_I * div_J * img_left_R(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j)) + 1);
            left_out_G(i,j) = (1 - div_I) * (1 - div_J) * img_left_G(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j))) + ...
                           div_I * (1 - div_J) * img_left_G(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j))) + ...
                           (1 - div_I) * div_J * img_left_G(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j)) + 1) + ...
                           div_I * div_J * img_left_G(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j)) + 1);
            left_out_B(i,j) = (1 - div_I) * (1 - div_J) * img_left_B(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j))) + ...
                           div_I * (1 - div_J) * img_left_B(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j))) + ...
                           (1 - div_I) * div_J * img_left_B(fix(I_out_left_bk_ori_left(i,j)), fix(J_out_left_bk_ori_left(i,j)) + 1) + ...
                           div_I * div_J * img_left_B(fix(I_out_left_bk_ori_left(i,j)) + 1, fix(J_out_left_bk_ori_left(i,j)) + 1);
                       
            left_loc(i,j) = 1;

                       
        elseif (round(I_out_left_bk_ori_left(i,j)) <= m_left_ori && round(J_out_left_bk_ori_left(i,j)) <= n_left_ori) &&...
                (round(I_out_left_bk_ori_left(i,j)) > 0 && round(J_out_left_bk_ori_left(i,j)) > 0) &&...
                (I_out_left_bk_ori_left(i,j) > 0 && J_out_left_bk_ori_left(i,j) > 0)
            left_out_R(i,j) = img_left_R(round(I_out_left_bk_ori_left(i,j)), round(J_out_left_bk_ori_left(i,j)));
            left_out_G(i,j) = img_left_G(round(I_out_left_bk_ori_left(i,j)), round(J_out_left_bk_ori_left(i,j)));
            left_out_B(i,j) = img_left_B(round(I_out_left_bk_ori_left(i,j)), round(J_out_left_bk_ori_left(i,j)));

            left_loc(i,j) = 1;
            
        else
            left_out_R(i,j) = 0;
            left_out_G(i,j) = 0;
            left_out_B(i,j) = 0;
        end
    end
end
left_out(:, :, 1) = left_out_R;
left_out(:, :, 2) = left_out_G;
left_out(:, :, 3) = left_out_B;
changed_img = left_out;
% imshow(left_out)
%% Find Location
% left mid
if mode == 1
    [m_mid, n_mid] = size(img_mid(:, :, 1));
    point_fea = matTranspose([feature_left_mean, 1]);  % feature_X -> J, feature_Y -> I
    point_fea_out_prime = H_left2mid * point_fea;
    center_left_J = point_fea_out_prime(1,1) / point_fea_out_prime(3,1);
    center_left_I = point_fea_out_prime(2,1) / point_fea_out_prime(3,1);

    center_left_I = center_left_I - I_new_trans_lm;
    center_left_J = center_left_J - J_new_trans_lm;
    
    fine_tune_I = -2;
    fine_tune_J = -4;
    
    det_I = center_left_I - feature_mid_mean(1, 2) + fine_tune_I;
    det_J = center_left_J - feature_mid_mean(1, 1) + n_left_ori + fine_tune_J;

    %% pause
    new_img_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_img_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_img_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_left_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_left_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_left_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_right_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_right_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_right_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_left_R(1:m_out_left, 1:n_out_left) = left_out_R;
    new_left_G(1:m_out_left, 1:n_out_left) = left_out_G;
    new_left_B(1:m_out_left, 1:n_out_left) = left_out_B;

    loc_mat = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));

    new_right_R(fix(det_I): m_mid + fix(det_I) - 1,...
        fix(det_J): n_mid + fix(det_J) - 1) = img_mid(:,:,1);
    new_right_G(fix(det_I): m_mid + fix(det_I) - 1,...
        fix(det_J): n_mid + fix(det_J) - 1) = img_mid(:,:,2);
    new_right_B(fix(det_I): m_mid + fix(det_I) - 1,...
        fix(det_J): n_mid + fix(det_J) - 1) = img_mid(:,:,3);

    new_left_rep = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_left_rep(1:m_out_left, 1:n_out_left) = left_loc;
    new_mid_rep = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , max(n_out_left, n_mid + fix(det_J) - 1));
    new_mid_rep(fix(det_I): m_mid + fix(det_I) - 1,...
        fix(det_J): n_mid + fix(det_J) - 1) = 1;

    [m_new, n_new] = size(new_img_R);


    for i=1:m_new
        for j=1:n_new
            if new_left_rep(i,j) == 1 && new_mid_rep(i,j) == 1
                new_img_R(i,j) = 0.5 * (new_left_R(i,j) + new_right_R(i,j,1));
                new_img_G(i,j) = 0.5 * (new_left_G(i,j) + new_right_G(i,j,1));
                new_img_B(i,j) = 0.5 * (new_left_B(i,j) + new_right_B(i,j,1));
                loc_mat(i,j) = 1;
            else
                if new_left_rep(i,j) == 1
                    new_img_R(i,j) = new_left_R(i,j);
                    new_img_G(i,j) = new_left_G(i,j);
                    new_img_B(i,j) = new_left_B(i,j);
                    loc_mat(i,j) = 1;

                end
                if new_mid_rep(i,j) == 1
                    new_img_R(i,j) = new_right_R(i,j,1);
                    new_img_G(i,j) = new_right_G(i,j,1);
                    new_img_B(i,j) = new_right_B(i,j,1);
                    loc_mat(i,j) = 1;
                end
            end
        end
    end
    new_img(:, :, 1) = new_img_R;
    new_img(:, :, 2) = new_img_G;
    new_img(:, :, 3) = new_img_B;
    % imshow(uint8(new_img));
    mid_ul_I = fix(det_I);
    mid_ul_J = fix(det_J);

% mid right
else
    [m_mid, n_mid] = size(img_mid(:, :, 1));
    point_fea = matTranspose([feature_left_mean, 1]);  % feature_X -> J, feature_Y -> I
    point_fea_out_prime = H_left2mid * point_fea;
    center_left_J = point_fea_out_prime(1,1) / point_fea_out_prime(3,1);
    center_left_I = point_fea_out_prime(2,1) / point_fea_out_prime(3,1);

    center_left_I = center_left_I - I_new_trans_lm;
    center_left_J = center_left_J - J_new_trans_lm;

    fine_tune_I = 4;
    fine_tune_J = -4;
    
    det_I = center_left_I - feature_mid_mean(1, 2) + fine_tune_I;
    det_J = n_mid - (center_left_J - feature_mid_mean(1, 1)) + fine_tune_J;
    
    new_img_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_img_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_img_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_left_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_left_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_left_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_right_R = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_right_G = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_right_B = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_left_R(fix(det_I): m_mid + fix(det_I) - 1, 1: n_mid) = img_mid(:,:,1);
    new_left_G(fix(det_I): m_mid + fix(det_I) - 1, 1: n_mid) = img_mid(:,:,2);
    new_left_B(fix(det_I): m_mid + fix(det_I) - 1, 1: n_mid) = img_mid(:,:,3);
    
    loc_mat = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));

    new_right_R(1: m_out_left, fix(det_J): n_out_left + fix(det_J) - 1) = left_out_R;
    new_right_G(1: m_out_left, fix(det_J): n_out_left + fix(det_J) - 1) = left_out_G;
    new_right_B(1: m_out_left, fix(det_J): n_out_left + fix(det_J) - 1) = left_out_B;
    new_left_rep = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_left_rep(fix(det_I): m_mid + fix(det_I) - 1, 1: n_mid) = 1;
    new_mid_rep = zeros(max(m_out_left, m_mid + fix(det_I) - 1) , n_out_left + fix(det_J));
    new_mid_rep(1: m_out_left, fix(det_J): n_out_left + fix(det_J) - 1) = left_loc;
    [m_new, n_new] = size(new_img_R);
    for i=1:m_new
        for j=1:n_new
            if new_left_rep(i,j) == 1 && new_mid_rep(i,j) == 1
                new_img_R(i,j) = 0.5 * (new_left_R(i,j) + new_right_R(i,j,1));
                new_img_G(i,j) = 0.5 * (new_left_G(i,j) + new_right_G(i,j,1));
                new_img_B(i,j) = 0.5 * (new_left_B(i,j) + new_right_B(i,j,1));
                loc_mat(i,j) = 1;

            else
                if new_left_rep(i,j) == 1
                    new_img_R(i,j) = new_left_R(i,j);
                    new_img_G(i,j) = new_left_G(i,j);
                    new_img_B(i,j) = new_left_B(i,j);
                    loc_mat(i,j) = 1;
                end
                if new_mid_rep(i,j) == 1
                    new_img_R(i,j) = new_right_R(i,j,1);
                    new_img_G(i,j) = new_right_G(i,j,1);
                    new_img_B(i,j) = new_right_B(i,j,1);
                    loc_mat(i,j) = 1;
                end
            end
        end
    end
    new_img(:, :, 1) = new_img_R;
    new_img(:, :, 2) = new_img_G;
    new_img(:, :, 3) = new_img_B;

    mid_ul_I = fix(det_I);
    mid_ul_J = 1;

end
end
