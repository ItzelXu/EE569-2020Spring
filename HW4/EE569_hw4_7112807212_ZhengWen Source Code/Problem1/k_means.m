% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function y = k_means(X, k)
[m,n] = size(X);
rand_index = randperm(n);
center = X(:, rand_index(1: k));

y = zeros(n, 1);
MAX_ITER = 50;
for iter=1: MAX_ITER
    for i=1:n
        min_dis = Inf;
        for j=1:k
            cur_dis = norm(X(:, i) - center(:, j));
            if cur_dis < min_dis
                min_dis = cur_dis;
                y(i, 1) = j;
            end
        end
    end
    new_cen = zeros(m,k);
    new_num = zeros(1,k);
    for i=1:n
        new_cen(:, y(i,1)) = new_cen(:, y(i,1)) + X(:, i);
        new_num(:, y(i,1)) = new_num(:, y(i,1)) + 1;
    end
    for i=1:k
        new_cen(:, i) = new_cen(:, i) / new_num(:, i);
    end
    center = new_cen;
end
end
