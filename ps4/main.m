clc;
clear;
close all;

fc = 10;
kf = 3;

freqs = [ 15 10 20 ];
amps  = [ 2 10 2 ];

freq_dev = kf * amps;
bandwidth = 2 * freq_dev + 2*freqs;
beta = freq_dev ./ freqs;
universal = [9 4 12] .* freq_dev;

narrowband = beta < 1;