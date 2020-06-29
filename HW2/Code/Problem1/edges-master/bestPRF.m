function [best_P, best_R, best_F] = bestPRF(cntR, sumR, cntP, sumP)
best_P = 0;
best_F = 0;
best_R = 0;
for i =1:length(cntR)
    P = cntP(i,1)/sumP(i,1);
    R = cntR(i,1)/sumR(i,1);
    F = ((2*P*R)/(P+R));
    if F > best_F
        best_F = F;
        best_P = P;
        best_R = R;
    end
end
end