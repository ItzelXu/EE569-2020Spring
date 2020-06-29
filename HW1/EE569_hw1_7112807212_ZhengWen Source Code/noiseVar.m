% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function var = noiseVar(array)

var = 0;
avg = noiseAvg(array);
for i=1:length(array)
    var = var + (array(i) - avg)^2;
end
var = var / length(array);
end