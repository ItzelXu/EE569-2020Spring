% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function bond = calBondof_1(img)

[m, n] = size(img);
padded_img = reflectionPad(img, 1);
bond = zeros(m,n);
for i=1:m
    for j=1:n
        if padded_img(i + 1, j + 1) == 0
            continue
        else
            if padded_img(i + 1 + 1, j + 1 + 1) == 1
                bond(i,j) = bond(i,j) + 1;
            end
            if padded_img(i + 1 - 1, j + 1 + 1) == 1
                bond(i,j) = bond(i,j) + 1;
            end
            if padded_img(i + 1 + 1, j + 1 - 1) == 1
                bond(i,j) = bond(i,j) + 1;
            end
            if padded_img(i + 1 - 1, j + 1 - 1) == 1
                bond(i,j) = bond(i,j) + 1;
            end
            if padded_img(i + 1, j + 1 + 1) == 1
                bond(i,j) = bond(i,j) + 2;
            end
            if padded_img(i + 1, j + 1 - 1) == 1
                bond(i,j) = bond(i,j) + 2;
            end
            if padded_img(i + 1 + 1, j + 1) == 1
                bond(i,j) = bond(i,j) + 2;
            end
            if padded_img(i + 1 - 1, j + 1) == 1
                bond(i,j) = bond(i,j) + 2;
            end
        end
    end
end
end