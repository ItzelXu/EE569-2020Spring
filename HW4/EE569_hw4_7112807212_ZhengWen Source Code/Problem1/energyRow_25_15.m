% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function energy_row_15 = energyRow_25_15(energy_row_25)

[~, n] = size(energy_row_25);

energy_row_15 = zeros(15, n);

energy_row_15(1, :) = energy_row_25(1, :);
energy_row_15(2, :) = (energy_row_25(2, :) + energy_row_25(6, :)) / 2;
energy_row_15(3, :) = (energy_row_25(8, :) + energy_row_25(12, :)) / 2;
energy_row_15(4, :) = energy_row_25(7, :);
energy_row_15(5, :) = (energy_row_25(3, :) + energy_row_25(11, :)) / 2;
energy_row_15(6, :) = (energy_row_25(9, :) + energy_row_25(17, :)) / 2;
energy_row_15(7, :) = energy_row_25(13, :);
energy_row_15(8, :) = (energy_row_25(4, :) + energy_row_25(16, :)) / 2;
energy_row_15(9, :) = (energy_row_25(10, :) + energy_row_25(22, :)) / 2;
energy_row_15(10, :) = energy_row_25(19, :);
energy_row_15(11, :) = (energy_row_25(5, :) + energy_row_25(21, :)) / 2;
energy_row_15(12, :) = (energy_row_25(14, :) + energy_row_25(18, :)) / 2;
energy_row_15(13, :) = energy_row_25(25, :);
energy_row_15(14, :) = (energy_row_25(20, :) + energy_row_25(24, :)) / 2;
energy_row_15(15, :) = (energy_row_25(15, :) + energy_row_25(23, :)) / 2;
