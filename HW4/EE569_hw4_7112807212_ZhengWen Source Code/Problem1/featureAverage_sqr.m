% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function energy = featureAverage_sqr(feature_map)

[m, n, c] = size(feature_map);

energy = zeros(c,1);

for k=1:c
    value = 0;
    for i=1:m
        for j=1:n
            value = value + feature_map(i,j,k) * feature_map(i,j,k);
        end
    end
%     value = value / (m * n);
    energy(k,1) = value;
end
end