% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function [num_alone, pos] = countAlone(img)

[m,n] = size(img);
img_pad = zeroPad(img, 1);
num_alone = 0;
pos = [];
for i=1:m
    for j=1:n
        if img_pad(i + 1, j + 1) == 0
            continue
        elseif ~img_pad(i + 1 - 1, j + 1 - 1) && ~img_pad(i + 1 - 1, j + 1) && ~img_pad(i + 1 - 1, j + 1 + 1) && ...
                ~img_pad(i + 1, j + 1 - 1) && ~img_pad(i + 1, j + 1 + 1) && ...
                ~img_pad(i + 1 + 1, j + 1 - 1) && ~img_pad(i + 1 + 1, j + 1) && ~img_pad(i + 1 + 1, j + 1 + 1)
            num_alone = num_alone + 1;
            pos(end + 1, :) = [i,j];
        end
    end
end
end