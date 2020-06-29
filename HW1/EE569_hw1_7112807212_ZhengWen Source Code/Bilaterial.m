% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function new_img = Bilaterial(img, r, sigmaC, sigmaS)    

[m,n]=size(img);
new_img=zeros(m,n);
panel=zeros(2*r+1,2*r+1);
panel_center=r+1;

for i=1:m
    for j=1:n    
        sum_de=0;        
        for k=-r:r
            for l=-r:r
                panel(k+panel_center,l+panel_center)=exp(-((k^2+l^2)/(2*sigmaC^2))-(img(be_m(i+k,m), be_m(j+l,n))-img(i,j))^2/(2*sigmaS^2));
                sum_de=sum_de+panel(k+panel_center,l+panel_center);
            end
        end
        
        sum_no=0;
        
        for k=-r:r
            for l=-r:r
                sum_no=sum_no+panel(k+panel_center,l+panel_center)*img(be_m(i+k,m),be_m(j+l,n));
            end
        end
        new_img(i,j)=round(sum_no/sum_de);
    end
end
end
