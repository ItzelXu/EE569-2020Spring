% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function res = filtImg(img, filter)
[m,n] = size(img);
rad_filter = fix(size(filter, 1) / 2);
pad_img = reflectionPad(img, rad_filter);

res = zeros(m,n);

for i=1:m
    for j=1:n
        cen_i = i + rad_filter;
        cen_j = j + rad_filter;
        for k = -rad_filter: rad_filter
            for l = -rad_filter: rad_filter
                res(i, j) = res(i, j) + pad_img(cen_i+k, cen_j+l) * filter(k + rad_filter + 1, l + rad_filter + 1);
            end
        end
    end
end
end

