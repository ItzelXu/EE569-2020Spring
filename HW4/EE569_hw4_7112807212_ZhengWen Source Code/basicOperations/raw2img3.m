% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function res = raw2img3(raw, m, n)
[R, G, B] = raw23D(raw, m, n);
res(:,:,1) = R; res(:,:,2) = G; res(:,:,3) = B; 
end