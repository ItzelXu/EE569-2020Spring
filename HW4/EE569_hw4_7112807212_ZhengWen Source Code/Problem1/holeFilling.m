% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020
function filled = holeFilling(img)

[m,n] = size(img);
filled = double(img);
visited = zeros(m,n);

area = [];
for i=1:m
    for j=1:n
        if ~visited(i, j)
            pixel = img(i,j);
            stack = [i,j];
            visited(i, j) = 1;
            current_area = 0;
            while stack
                a = stack(end, 1);
                b = stack(end, 2);
                stack(end, :) = [];
                current_area = current_area + 1;
                if a - 1 >= 1 && ~visited(a - 1, b) && img(a - 1, b) == pixel
                    stack(end + 1, :) = [a - 1, b];
                    visited(a - 1, b) = 1;
                end
                if b - 1 >= 1 && ~visited(a, b - 1) && img(a, b - 1) == pixel
                    stack(end + 1, :) = [a, b - 1];
                    visited(a, b - 1) = 1;
                end
                if b + 1 <= n && ~visited(a, b + 1) && img(a, b + 1) == pixel
                    stack(end + 1, :) = [a, b + 1];
                    visited(a, b + 1) = 1;
                end
                if a + 1 <= m && ~visited(a + 1, b) && img(a + 1, b) == pixel
                    stack(end + 1, :) = [a + 1, b];
                    visited(a + 1, b) = 1;
                end
            end
            area(end + 1) = current_area;
        end
    end
end

area = sort(area, 'descend');
target_area = area(7);
%%

visited = zeros(m,n);
for i=1:m
    for j=1:n
        if ~visited(i, j)
            pixel = img(i,j);
            stack = [i,j];
            visited(i, j) = 1;
            current_area = 0;
            path_i = [];
            path_j = [];
            while stack
                a = stack(end, 1);
                b = stack(end, 2);
                stack(end, :) = [];
                path_i(end + 1) = a;
                path_j(end + 1) = b;
                current_area = current_area + 1;
                if a - 1 >= 1 && ~visited(a - 1, b) && img(a - 1, b) == pixel
                    stack(end + 1, :) = [a - 1, b];
                    visited(a - 1, b) = 1;
                end
                if b - 1 >= 1 && ~visited(a, b - 1) && img(a, b - 1) == pixel
                    stack(end + 1, :) = [a, b - 1];
                    visited(a, b - 1) = 1;
                end
                if b + 1 <= n && ~visited(a, b + 1) && img(a, b + 1) == pixel
                    stack(end + 1, :) = [a, b + 1];
                    visited(a, b + 1) = 1;
                end
                if a + 1 <= m && ~visited(a + 1, b) && img(a + 1, b) == pixel
                    stack(end + 1, :) = [a + 1, b];
                    visited(a + 1, b) = 1;
                end
            end
            if current_area < target_area || current_area == area(6)
                for k = 1: length(path_i)
                    filled(path_i(k), path_j(k)) = -1;
                end
                
                
            end 
        end
    end
end

max_iter = 200;
for iter = 1:max_iter
    for j_sub = 1:n
        for i_sub = m:-1:1
            if filled(i_sub,j_sub) == -1
                if i_sub + 1 < m && filled(i_sub + 1, j_sub) ~= -1
                    filled(i_sub,j_sub) = filled(i_sub + 1, j_sub);
                end

                if i_sub - 1 > 0 && filled(i_sub - 1, j_sub) ~= -1
                    filled(i_sub,j_sub) = filled(i_sub - 1, j_sub);
                end
                if j_sub - 1 > 0 && filled(i_sub, j_sub - 1) ~= -1
                    filled(i_sub,j_sub) = filled(i_sub, j_sub - 1);
                end
                if j_sub + 1 < n && filled(i_sub, j_sub + 1) ~= -1
                    filled(i_sub,j_sub) = filled(i_sub, j_sub + 1);
                end
            end
        end
    end
end


end