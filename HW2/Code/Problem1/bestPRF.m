% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 2/11/2020

function [P_max, R_max, F_max] = bestPRF(cntR, sumR, cntP, sumP)
P_max = 0;
R_max = 0;
F_max = 0;
for i =1:length(cntR)
    P = cntP(i,1)/sumP(i,1);
    R = cntR(i,1)/sumR(i,1);
    F = ((2*P*R)/(P+R));
    if F > F_max
        P_max = P;
        R_max = R;
        F_max = F;
    end
end
end