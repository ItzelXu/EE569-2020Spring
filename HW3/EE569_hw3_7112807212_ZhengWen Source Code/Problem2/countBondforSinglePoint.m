% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function bond = countBondforSinglePoint(img, i, j)

bond = 0;
if img(i - 1, j - 1)
    bond = bond + 1;
end
if img(i + 1, j - 1)
    bond = bond + 1;
end
if img(i + 1, j + 1)
    bond = bond + 1;
end
if img(i - 1, j + 1)
    bond = bond + 1;
end
if img(i, j + 1)
    bond = bond + 2;
end
if img(i, j - 1)
    bond = bond + 2;
end
if img(i + 1, j)
    bond = bond + 2;
end
if img(i - 1, j)
    bond = bond + 2;
end
end
