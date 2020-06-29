% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function double_pre_char = char2double(char)

[m,n] = size(char);
double_pre_char = zeros(size(char));
for i=1:m
    for j=1:n
        double_pre_char(i,j) = bin2dec(char(i,j));
    end
end

end