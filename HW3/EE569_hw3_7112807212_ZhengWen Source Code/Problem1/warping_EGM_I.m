% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function [I, J] = warping_EGM_I(img)
[m,n] = size(img);
[J, I] = matMeshgrid(1:n, 1:m);
I_new = zeros(size(I));
J_new = zeros(size(J));

I = matMulConst(matAddConst(I, -1), 1/m);
J = matMulConst(matAddConst(J, -1), 1/n);
for i=1:m
    for j=1:n
        I_new(i,j) = 0.5 * sqrt(2 + I(i,j)^2 - J(i,j)^2 + 2 * sqrt(2) * I(i,j)) - 0.5 * sqrt(2 + I(i,j)^2 - J(i,j)^2 - 2 * sqrt(2) * I(i,j));
        J_new(i,j) = 0.5 * sqrt(2 - I(i,j)^2 + J(i,j)^2 + 2 * sqrt(2) * J(i,j)) - 0.5 * sqrt(2 - I(i,j)^2 + J(i,j)^2 - 2 * sqrt(2) * J(i,j));
    end
end
I = matAddConst(matMulConst(I_new, m), 1);
J = matAddConst(matMulConst(J_new, n), 1);
end