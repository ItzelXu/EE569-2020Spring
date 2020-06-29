% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function avg = noiseMean(ori_raw, noised_raw)

len = length(ori_raw);
for i = 1:len
    avg = avg + (noised_raw(i) - ori_raw(i));
end

avg = avg / len;

end