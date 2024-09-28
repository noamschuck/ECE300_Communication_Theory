clc;
clear;
close all;

A = 1;
W = 1;

f = -W:.001:W;
X = A/(2*W) * ( 1 + cos(pi*f/W) ) .* rectangularPulse(-W, W, f);

t = -10:.001:10;
x = A * ( sinc(2*W*t) + 1/2*sinc(2*W*(t+1/(2*W))) + 1/2*sinc(2*W*(t-1/(2*W))) );

figure;

subplot(1, 2, 1);
plot(t, x);
title('x(t)');

subplot(1, 2, 2);
plot([-2 f 2], [0 X 0]);
title('X(f)');
xlim([-2, 2]);
ylim([-1 inf]);
