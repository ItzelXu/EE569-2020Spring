% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function normalized = gradNorm(rawGrad)

[m,n] = size(rawGrad);
normalized = zeros(m,n);
maximum = -10000;
minimum = 10000;
for i=1:m
    for j=1:n
        if rawGrad(i,j)>maximum
            maximum = rawGrad(i,j);
        end
        if rawGrad(i,j)<minimum
            minimum = rawGrad(i,j);
        end
    end
end

for i=1:m
    for j=1:n
        normalized(i,j)=(255*(rawGrad(i,j)-minimum)) / (maximum-minimum);
    end
end