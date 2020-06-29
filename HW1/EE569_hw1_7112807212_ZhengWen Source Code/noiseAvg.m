% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function avg = noiseAvg(array)

sum = 0;
for i=1:length(array)
    sum = sum + array(i);
end
avg = sum/length(array);
end