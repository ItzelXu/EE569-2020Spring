% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function [R, G, B] = raw23D(raw, m, n)

R = zeros(m,n);
G = zeros(m,n);
B = zeros(m,n);
k=1;
for i=1:m
    for j=1:n
        R(i,j) = raw(k);
        k = k+1;
        G(i,j) = raw(k);
        k = k+1;
        B(i,j) = raw(k);
        k = k+1;
    end
end
end
