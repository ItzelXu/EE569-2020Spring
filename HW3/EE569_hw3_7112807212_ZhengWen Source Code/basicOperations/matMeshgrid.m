% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function [J, I] = matMeshgrid(one2len_n, one2len_m)
    n = one2len_n(end);
    m = one2len_m(end);
    J = zeros(m, n);
    I = zeros(m, n);
    for i=1:m
        for j=1:n
            I(i,j) = i;
            J(i,j) = j;
        end
    end
end