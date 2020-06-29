% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function img = step_delete(img, delete_if_1)

[m,n] = size(img);
for i=1:m
    for j=1:n
        if img(i,j) == 0
            continue
        end
        if delete_if_1(i,j) == 1
            img(i,j) = 0;
        end
    end
end
end