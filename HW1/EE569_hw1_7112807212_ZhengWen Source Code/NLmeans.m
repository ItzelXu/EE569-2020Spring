% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 1/27/2020

function res_img = NLmeans(img, small_r, large_r, h, a)
%h: standard division
%a: gauss standard devision

[m,n]=size(img);
res_img=zeros(m,n);
PaddedImg=reflectionPad(img,small_r);
panel=zeros(2*small_r+1,2*small_r+1);
panel_center=small_r+1;
for i=1:2*small_r+1
    for j=1:2*small_r+1
        panel(i,j)=(1/sqrt(2*pi*a^2))*exp(-((i-panel_center)^2+(j-panel_center)^2)/(2*a^2));
    end
end

sumPanel = matSum(panel);
for i=1:2*small_r+1
    for j=1:2*small_r+1
        panel(i,j)=panel(i,j)/sumPanel;
    end
end

for i=1:m
    for j=1:n
        i_ori=i+small_r;
        j_ori=j+small_r;
        W1=PaddedImg(i_ori-small_r:i_ori+small_r,j_ori-small_r:j_ori+small_r);
        W2_imin = max(i_ori-large_r,small_r+1);
        W2_imax = min(i_ori+large_r,m+small_r);
        W2_jmin = max(j_ori-large_r,small_r+1);
        W2_jmax = min(j_ori+large_r,n+small_r);
        
        nom=0;
        den=0;

        for k=W2_imin:W2_imax
            for l=W2_jmin:W2_jmax
                W2=PaddedImg(k-small_r:k+small_r,l-small_r:l+small_r);
                Dist2=matSum(matDotMul(panel,matDotMul(matSub(W1,W2),matSub(W1,W2))));
                w=exp(-Dist2/(h^2));
                den=den+w;
                nom=nom+w*PaddedImg(k,l);
            end
        end
        res_img(i,j)=nom/den;
    end
end
end
