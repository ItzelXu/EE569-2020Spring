% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

function energy_15 = energy_25_15(energy_25)
energy_15 = zeros(15, 1);
energy_15(1) = energy_25(1);
energy_15(2) = (energy_25(2) + energy_25(6)) / 2;
energy_15(3) = (energy_25(8) + energy_25(12)) / 2;
energy_15(4) = energy_25(7);
energy_15(5) = (energy_25(3) + energy_25(11)) / 2;
energy_15(6) = (energy_25(9) + energy_25(17)) / 2;
energy_15(7) = energy_25(13);
energy_15(8) = (energy_25(4) + energy_25(16)) / 2;
energy_15(9) = (energy_25(10) + energy_25(22)) / 2;
energy_15(10) = energy_25(19);
energy_15(11) = (energy_25(5) + energy_25(21)) / 2;
energy_15(12) = (energy_25(14) + energy_25(18)) / 2;
energy_15(13) = energy_25(25);
energy_15(14) = (energy_25(20) + energy_25(24)) / 2;
energy_15(15) = (energy_25(15) + energy_25(23)) / 2;
end
