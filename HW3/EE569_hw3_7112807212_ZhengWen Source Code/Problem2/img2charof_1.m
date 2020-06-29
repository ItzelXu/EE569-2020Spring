% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function char_img = img2charof_1(img)
[m,n] = size(img);
padded_img = reflectionPad(img, 1);
char_img = strings(m, n);
for i=1:m
    for j=1:n
        if img(i,j) == 0
            char_img(i,j) = '00000000';
        else
            char = '';
            for k=-1:1
                for l=-1:1
                    if k == 0 && l == 0
                        continue
                    end
                    char = [char, dec2bin(padded_img(i + 1 + k, j + 1 + l))];
                end
            end
            char_img(i,j) = char;
        end
    end
end
end