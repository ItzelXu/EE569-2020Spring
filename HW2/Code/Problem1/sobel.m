% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function [X, Y, final] = sobel(gray)

[m,n] = size(gray);

panel_X = [-1, 0, 1;
            -2, 0, 2;
            -1, 0, 1];
panel_Y = [1, 2, 1;
           0, 0, 0;
          -1,-2,-1];
paddedGray = reflectionPad(gray, 1);
X = zeros(m,n);
Y = zeros(m,n);
final = zeros(m,n);
for i=1:m
    for j=1:n
        
        i_pad = i+1;
        j_pad = j+1;
        
        for k=-1:1
            for l=-1:1
                X(i,j) = X(i,j) + paddedGray(i_pad+k, j_pad+l)*panel_X(k+2,l+2);
            end
        end

        for k=-1:1
            for l=-1:1
                Y(i,j) = Y(i,j) + paddedGray(i_pad+k, j_pad+l)*panel_Y(k+2,l+2);
            end
        end
        
    end
end

for i=1:m
    for j=1:n
        final(i,j)=sqrt(X(i,j)^2 + Y(i,j)^2);
    end
end
