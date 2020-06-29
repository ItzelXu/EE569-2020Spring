% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/3/2020

function new_img = project2Square(img, I, J)
[m,n] = size(img);
new_img = zeros(m,n);
% for i=1:m
%     for j=1:n
%         if I(i,j)^2 + J(i,j)^2 <= (m - 1)^2
%             new_img(i,j) = img(round(I(i,j)), round(J(i,j)));
%         else
%             new_img(i,j) = img(fix(I(i,j)), fix(J(i,j)));
%         end
%     end
% end
for i=1:m
    for j=1:n
% with fix
        if I(i,j)^2 + J(i,j)^2 <= m^2
            if I(i,j) == 1 || J(i,j) == 1
                new_img(i,j) = img(round(I(i,j)), round(J(i,j)));
            else
                div_I = I(i,j) - fix(I(i,j));
                div_J = J(i,j) - fix(J(i,j));
                new_img(i,j) = (1 - div_I) * (1 - div_J) * img(fix(I(i,j)), fix(J(i,j))) + ...
                                div_I * (1 - div_J) * img(fix(I(i,j)) + 1, fix(J(i,j))) + ...
                                (1 - div_I) * div_J * img(fix(I(i,j)), fix(J(i,j)) + 1) + ...
                                div_I * div_J * img(fix(I(i,j)) + 1, fix(J(i,j)) + 1);
            end
        else
            new_img(i,j) = img(fix(I(i,j)), fix(J(i,j)));
        end

% % without fix
%         if I(i,j) == 1 || J(i,j) == 1
%             new_img(i,j) = img(round(I(i,j)), round(J(i,j)));
%         else
%             div_I = I(i,j) - fix(I(i,j));
%             div_J = J(i,j) - fix(J(i,j));
%             new_img(i,j) = (1 - div_I) * (1 - div_J) * img(fix(I(i,j)), fix(J(i,j))) + ...
%                             div_I * (1 - div_J) * img(fix(I(i,j)) + 1, fix(J(i,j))) + ...
%                             (1 - div_I) * div_J * img(fix(I(i,j)), fix(J(i,j)) + 1) + ...
%                             div_I * div_J * img(fix(I(i,j)) + 1, fix(J(i,j)) + 1);
%         end

    end
end
end