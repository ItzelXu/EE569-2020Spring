% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function new_img = Basic(img, r, pattern, a)
% pattern = 1: Normal
% pattern = 2: Gaussian
[m,n]=size(img);
new_img=zeros(m,n);
panel=zeros(2*r+1, 2*r+1);
panel_center=r+1;
if pattern==1
    for i=1:2*r+1
        for j=1:2*r+1
            panel(i,j) = 1/((2*r+1)*(2*r+1));
        end
    end
end

if pattern==2
    for i=1:2*r+1
        for j=1:2*r+1
            panel(i,j)=(1/sqrt(2*pi*a^2))*exp(-((i-panel_center)^2+(j-panel_center)^2)/(2*a^2));
        end
    end
end

panel = panelNomalize(panel);

for i=1:m
    for j=1:n    
        sum=0;
        for k=-r:r
            for l=-r:r
                sum=sum+round(panel(k+panel_center,l+panel_center)*img(be_m(i+k,m),be_m(j+l,n)));
            end
        end
        new_img(i,j)=sum;
    end
end
end
