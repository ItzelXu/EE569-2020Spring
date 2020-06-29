% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function bin_img = bin_01(img)

[m,n] = size(img);
bin_img=zeros(m,n);
for i=1:m
    for j=1:n
        if img(i,j)>0.5
            bin_img(i,j)=1;
        else
            bin_img(i,j)=0;
        end
    end
end

end