% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = PCA_dim(X, dim)
% X = (X - mean(X)) ./ std(X);
% covar = X' * X;
% red_dim = dim - 1;
% [V,D] = eig(covar);
% V = V(:, end-red_dim: end);
% V = V(:, end:-1:1);
% res = X * V;
% res = res';
% 

X = matDotDiv(X - matMean(X), matStd(X));
covar = matMul(matTranspose(X), X);
red_dim = dim - 1;
[V,D] = eig(covar);
V = V(:, end-red_dim: end);
V = V(:, end:-1:1);
res = matMul(X, V);
res = matTranspose(res);


end


