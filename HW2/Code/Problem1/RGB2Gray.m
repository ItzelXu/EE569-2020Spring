% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function gray = RGB2Gray(R,G,B)

[m,n] = size(R);
gray = zeros(m,n);
for i=1:m
    for j=1:n
        gray(i,j) = 0.2989*R(i,j) + 0.5870*G(i,j)+ 0.1140*B(i,j);
    end
end
end