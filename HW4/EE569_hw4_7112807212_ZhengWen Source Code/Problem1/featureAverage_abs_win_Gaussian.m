% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function energy_row = featureAverage_abs_win_Gaussian(feature_map, rad, sigma)

[m, n, c] = size(feature_map);
energy_map = zeros(m,n,c);
window = fspecial('gaussian', rad * 2 + 1, sigma);

for chan=1:c
    cur_fm = feature_map(:, :, chan);
    padd_fm = reflectionPad(cur_fm,rad);
    for i=1:m
        for j=1:n
            value = 0;
            cen_i = i + rad;
            cen_j = j + rad;
            for k = -rad: rad
                for l = -rad: rad
                    value = value + window(rad + k + 1, rad + l + 1) * abs(padd_fm(cen_i + k, cen_j + l));
                end
            end
            value = value / (rad * rad);
            energy_map(i, j , chan) = value;
        end
    end
end

energy_row = zeros(c, m * n);
count = 1;
for i=1:m
    for j=1:n
        energy_row(:, count) = reshape(energy_map(i, j, :), 25, 1);
        count = count + 1;
    end
end

end