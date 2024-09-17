clc;
clear;
close all;

% Part A
PSK_4 = 2/sqrt(2) * exp(pi/4:pi/2:7*pi/4);
PSK_8 = exp(1j*(0:pi/4:(7/4*pi)));
QAM_16 = reshape([-1.5 -.5 .5 1.5] + [1.5j; .5j; -.5j; -1.5j], [1, 16]);
QAM_32 = reshape([-2.5 -1.5 -.5 .5 1.5 2.5] + [2.5j; 1.5j; .5j; -.5j; -1.5j; -2.5j] , [1, 36]);
QAM_32(36) = [];
QAM_32(31) = [];
QAM_32(6) = [];
QAM_32(1) = [];

% Part B
Eb_4 = 1/2 * (1/4 * sum(PSK_4.^2));
Eb_8 = 1/3 * (1/8 * sum(PSK_8.^2));
Eb_16 = 1/4 * (1/16 * sum(QAM_16.^2));
Eb_32 = 1/5 * (1/32 * sum(QAM_32.^2));

% Part C


