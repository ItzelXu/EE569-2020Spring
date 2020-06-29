% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function img_diffed = errorDiffusion(img, ker, ker_re)

[m,n]=size(img);
[km,kn]=size(ker);

cen_km=round(km/2);
cen_kn=round(kn/2);

img_pad=zeroPad(img,fix(km/2));
img_res=zeros(size(img_pad));

for i=1:m
    if mod(i,2)==1
        for j=1:n
            if img_pad(i+cen_km-1, j+cen_kn-1) > 0.5
                img_res(i+cen_km-1, j+cen_kn-1) = 1;
            else
                img_res(i+cen_km-1, j+cen_kn-1) = 0;
            end
            
            err = img_pad(i+cen_km-1, j+cen_kn-1) - img_res(i+cen_km-1, j+cen_kn-1);
            
            for k=-fix(km/2):fix(km/2)
                for l=-fix(km/2):fix(km/2)
                    
                    img_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        img_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err*ker(k+cen_km,l+cen_kn);
                    
                end
            end
        end
    else
        for j=n:-1:1
            
            if img_pad(i+cen_km-1, j+cen_kn-1) > 0.5
                img_res(i+cen_km-1, j+cen_kn-1) = 1;
            else
                img_res(i+cen_km-1, j+cen_kn-1) = 0;
            end
            
            err = img_pad(i+cen_km-1, j+cen_kn-1) - img_res(i+cen_km-1, j+cen_kn-1);
            
            for k=-fix(km/2):fix(km/2)
                for l=-fix(km/2):fix(km/2)
                    
                    img_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        img_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err*ker_re(k+cen_km,l+cen_kn);
                    
                end
            end
        end
    end
end

img_diffed = img_res(cen_km:m+cen_km-1, cen_kn:n+cen_km-1);

end