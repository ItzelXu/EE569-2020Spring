% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function T = transform_compute(in_matched, out_matched)
% fixed_1  : x'  fixed_2  : y'
% changed_1: x   changed_2: x
% start from (0,0), must -1 to use.
[m, ~] = size(out_matched);
A = zeros(2*m, 8);
b = zeros(2*m, 1);
in_matched = matAddConst(in_matched, -1);
out_matched = matAddConst(out_matched, -1);


for i=1:m
    A(2*i - 1, :) = [in_matched(i,1), in_matched(i,2), 1, 0, 0, 0,...
        -in_matched(i,1)*out_matched(i,1), -in_matched(i,2)*out_matched(i,1)];
    A(2*i, :) = [0, 0, 0, in_matched(i,1), in_matched(i,2), 1,...
        -in_matched(i,1)*out_matched(i,2), -in_matched(i,2)*out_matched(i,2)];
    b(2*i - 1) = out_matched(i,1);
    b(2*i) = out_matched(i,2);
end

temp = A \ b;
temp = [temp; 1];
T = zeros(3,3);
count = 1;

for i=1:3
    for j=1:3
        T(i,j) = temp(count);
        count = count + 1;
    end
end

end



        