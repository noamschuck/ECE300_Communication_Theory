clc;
clear;
close all;

%% Question 2
fc = 10;
kf = 3;

freqs = [ 15 10 20 ];
amps  = [ 2 10 2 ];

freq_dev = kf * amps;
bandwidth = 2 * freq_dev + 2*freqs;
beta = freq_dev ./ freqs;
universal = [9 4 12] .* freq_dev;

narrowband = beta < 1;

%% Question 3

ka = 2;
fc = 10;
ac = 2;

amps = [ .4; .45; .6 ];

fs = 100;
t = 0:1/fs:2000/fs-1/fs;

m = amps .* sin(2*pi*2*t);
x = ac * (ones(size(m)) + ka*m) .* cos(2*pi*fc*t);

mod_index = ka*amps'*100;
over_mod = mod_index > 100;


for i = 1:3
    fprintf("Amp = %f V\n", amps(i));
    fprintf("  Modulation Index: %d\n", mod_index(i));
    fprintf("  Overmodulated? :  %d\n\n", over_mod(i));

    figure;
    plot(t, x(i, :));
    title("Signal Modulated with Amplitude " + amps(i));
    xlabel("time (s)");
    ylabel("amplitude (V)");
end
