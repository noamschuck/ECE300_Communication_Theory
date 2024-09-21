clc;
clear;
close all;

A = 1;
W = 1;

f = -W:.001:W;
X = A/(2*W) * ( 1 + cos(pi*f/W) ) .* rectangularPulse(-1/(4*W), 1/(4*W), f);

t = -10:.01:10;
x = A * ( sinc(2*W*t) + 1/2*sinc(2*W*(t+1/(2*W))) + 1/2*sinc(2*W*(t-1/(2*W))) );

figure;

subplot(2, 1, 1);
plot(t, x);
title('x(t)');

subplot(2, 1, 2);
plot(f, X);
title('X(f)');
