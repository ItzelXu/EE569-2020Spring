% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function [P_sum, R_sum, F_sum] = calculatePRF(cntR, sumR, cntP, sumP)
P_sum = 0;
R_sum = 0;
F_sum = 0;
for i =1:length(cntR)
    P = cntP(i,1)/sumP(i,1);
    R = cntR(i,1)/sumR(i,1);
    P_sum = P_sum+P;
    R_sum = R_sum+R;
    F_sum = F_sum+ ((2*P*R)/(P+R));
end

P_sum = P_sum/length(cntP);
R_sum = R_sum/length(cntP);
F_sum = F_sum/length(cntP);

end