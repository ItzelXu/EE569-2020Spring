function binarized = binarize(img, threshold)
frequency = HisCount(img);
sum_array = TotalSum(frequency);
partition = sum_array(length(sum_array)) * threshold;
for i=1:length(sum_array)
    if sum_array(i) >= partition
        partition = i-1;
        break;
    end
end

[m,n]=size(img);
binarized = zeros(m,n);
for i=1:m
    for j=1:n
        if img(i,j)>partition
            binarized(i,j)=255;
        else
            binarized(i,j)=0;
        end
    end
end
end