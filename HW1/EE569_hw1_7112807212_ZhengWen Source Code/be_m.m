% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function new_index = be_m(index, m)
    if index < 1
        new_index = 1 - index;
    elseif index > m
        new_index = m - (index - m) + 1;
    else
        new_index = index;
    end
end