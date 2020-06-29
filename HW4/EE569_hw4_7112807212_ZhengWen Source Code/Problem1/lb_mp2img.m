% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function image = lb_mp2img(label_map, num_label)
[m,n] = size(label_map);
image = zeros(m,n);

diff = 255 / (num_label - 1);
pixel = 0:diff:255;

for i=1:m
    for j=1:n
        image(i,j) = pixel(label_map(i,j));
    end
end
end