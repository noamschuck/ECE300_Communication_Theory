clc;
clear;
close all;

%% Part A
PSK_4 = 1/sqrt(2) * exp(1j*(pi/4:pi/2:7*pi/4));
PSK_8 = exp(1j*(0:pi/4:(7/4*pi)));
QAM_16 = reshape([-1.5 -.5 .5 1.5] + [1.5j; .5j; -.5j; -1.5j], [1, 16]);
QAM_32 = reshape([-2.5 -1.5 -.5 .5 1.5 2.5] + [2.5j; 1.5j; .5j; -.5j; -1.5j; -2.5j] , [1, 36]);
QAM_32(36) = [];
QAM_32(31) = [];
QAM_32(6) = [];
QAM_32(1) = [];

%% Part B
Eb_4 = 1/2 * (1/4 * sum(abs(PSK_4).^2))
Eb_8 = 1/3 * (1/8 * sum(abs(PSK_8).^2))
Eb_16 = 1/4 * (1/16 * sum(abs(QAM_16).^2))
Eb_32 = 1/5 * (1/32 * sum(abs(QAM_32).^2))

%% Part C
N = 2;

n_4 = 2/N;
n_8 = 3/N;
n_16 = 4/N;
n_32 = 5/N;

%% Part D
% 4-PSK is the most power efficient because the points are closer
% and have less of an amplitude so they take less power to
% generate.

%% Part E
% 32-QAM is the most spectrally efficient because
% its n it sends more bits per symbol per dimension than
% the other constillations

%% Part F
% This is generally true, but not a hard rule. The more dimensions,
% you have, you can reduce the power and maintain a high spectral efficiency.
