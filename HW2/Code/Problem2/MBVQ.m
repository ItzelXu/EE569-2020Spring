% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function img_diffed = MBVQ(R ,G, B, ker, ker_re)

[m,n]=size(R);
[km,kn]=size(ker);

cen_km=round(km/2);
cen_kn=round(kn/2);

R_pad=zeroPad(R,fix(km/2));
G_pad=zeroPad(G,fix(km/2));
B_pad=zeroPad(B,fix(km/2));

R_res=zeros(size(R_pad));
G_res=zeros(size(G_pad));
B_res=zeros(size(B_pad));


for i=1:m
    if mod(i,2)==1
        for j=1:n
            
            [R_res(i+cen_km-1, j+cen_kn-1),...
                G_res(i+cen_km-1, j+cen_kn-1),...
                B_res(i+cen_km-1, j+cen_kn-1)]...
                =decidePix(R_pad(i+cen_km-1, j+cen_kn-1),...
                G_pad(i+cen_km-1, j+cen_kn-1),...
                B_pad(i+cen_km-1, j+cen_kn-1));
            
            err_R = R_pad(i+cen_km-1, j+cen_kn-1) - R_res(i+cen_km-1, j+cen_kn-1);
            err_G = G_pad(i+cen_km-1, j+cen_kn-1) - G_res(i+cen_km-1, j+cen_kn-1);
            err_B = B_pad(i+cen_km-1, j+cen_kn-1) - B_res(i+cen_km-1, j+cen_kn-1);
            
            for k=-fix(km/2):fix(km/2)
                for l=-fix(km/2):fix(km/2)
                    
                    R_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        R_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_R*ker(k+cen_km,l+cen_kn);
                    G_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        G_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_G*ker(k+cen_km,l+cen_kn);
                    B_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        B_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_B*ker(k+cen_km,l+cen_kn);
                    
                end
            end
        end
    else
        for j=n:-1:1
            
            [R_res(i+cen_km-1, j+cen_kn-1),...
                G_res(i+cen_km-1, j+cen_kn-1),...
                B_res(i+cen_km-1, j+cen_kn-1)]...
                =decidePix(R_pad(i+cen_km-1, j+cen_kn-1),...
                G_pad(i+cen_km-1, j+cen_kn-1),...
                B_pad(i+cen_km-1, j+cen_kn-1));
            
            err_R = R_pad(i+cen_km-1, j+cen_kn-1) - R_res(i+cen_km-1, j+cen_kn-1);
            err_G = G_pad(i+cen_km-1, j+cen_kn-1) - G_res(i+cen_km-1, j+cen_kn-1);
            err_B = B_pad(i+cen_km-1, j+cen_kn-1) - B_res(i+cen_km-1, j+cen_kn-1);
            
            for k=-fix(km/2):fix(km/2)
                for l=-fix(km/2):fix(km/2)
                    
                    R_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        R_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_R*ker_re(k+cen_km,l+cen_kn);
                    G_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        G_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_G*ker_re(k+cen_km,l+cen_kn);
                    B_pad(i+cen_km-1 + k, j+cen_kn-1 + l) = ...
                        B_pad(i+cen_km-1 + k, j+cen_kn-1 + l)+...
                        err_B*ker_re(k+cen_km,l+cen_kn);

                    
                end
            end
        end
    end
end

img_diffed(:,:,1)=R_res(cen_km:m+cen_km-1, cen_kn:n+cen_km-1);
img_diffed(:,:,2)=G_res(cen_km:m+cen_km-1, cen_kn:n+cen_km-1);
img_diffed(:,:,3)=B_res(cen_km:m+cen_km-1, cen_kn:n+cen_km-1);


end