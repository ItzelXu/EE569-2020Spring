% Name: Zheng Wen
% USC ID: 7112807212
% USC Email: zwen1423@usc.edu
% Submission Date 3/19/2020

w = -pi:0.001:pi;
L5 = 2 * cos(2*w) + 8 * cos(w) + 6;
E5 = -2 * sin(2*w) - 4 * sin(w);
S5 = 2 - 2 * cos(2*w);
W5 = -2 * sin(2*w) + 4 * sin(w);
R5 = 2 * cos(2*w) - 8 * cos(w) + 6;
f = figure(1);
plot(w, abs(L5));
set(gca,'XTick',[-pi:pi/2:pi])
set(gca,'xtickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Amplitude')
title('L5')
saveas(f, 'L5 response.tif');

f = figure(2);
plot(w, abs(E5));
title('E5')
set(gca,'XTick',[-pi:pi/2:pi])
set(gca,'xtickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Amplitude')
saveas(f, 'E5 response.tif')

f = figure(3);
plot(w, abs(S5));
title('S5')
set(gca,'XTick',[-pi:pi/2:pi])
set(gca,'xtickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Amplitude')
saveas(f, 'S5 response.tif')


f = figure(4);
plot(w, abs(W5));
title('W5')
set(gca,'XTick',[-pi:pi/2:pi])
set(gca,'xtickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Amplitude')
saveas(f, 'W5 response.tif')

f = figure(5);
plot(w, abs(R5));
title('R5')
set(gca,'XTick',[-pi:pi/2:pi])
set(gca,'xtickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('Frequency')
ylabel('Amplitude')
saveas(f, 'R5 response.tif')
