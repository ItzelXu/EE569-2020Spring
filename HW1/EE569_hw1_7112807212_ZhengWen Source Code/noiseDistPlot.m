% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function noiseDistPlot(ori_raw, noised_raw)

len = length(ori_raw);
MAXIMUM = -10000;
MINIMUM = 10000;

for i = 1:len
    if noised_raw(i) - ori_raw(i) > MAXIMUM
        MAXIMUM = noised_raw(i) - ori_raw(i);
    end
    if noised_raw(i) - ori_raw(i) < MINIMUM
        MINIMUM = noised_raw(i) - ori_raw(i);
    end
end

res = zeros(MAXIMUM - MINIMUM + 1, 1);

for i = 1:len
    res(noised_raw(i) - ori_raw(i) - MINIMUM + 1) = res(noised_raw(i) - ori_raw(i) - MINIMUM + 1) + 1;
end
figure(100);
x_axis = MINIMUM:MAXIMUM;
bar(x_axis, res)

end