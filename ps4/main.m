clc;
clear;
close all;

format long;

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

%% Question 4

syms r

eq1 = 10e-4 == exp(-r^2/2);

sol = solve([eq1], [r]);

threshold = double(sol(1));
n = 1e7;
sigma = [10; 10; 10] .^ [0; -1/10; 1/10]; 
p = exp(-threshold^2*ones(size(sigma))/2./sigma);
R =  sqrt(sigma) .* abs(randn(3,n) + 1j*randn(3,n));

percent = sum(R > threshold, 2)/length(R);

for i = 1:3
    figure; 
    plot(R(i, :));
    yline(threshold, "-r", "Threshold", 'LineWidth', 3);
    title("R with sigma^2 = " + sigma(i));

    fprintf("Fraction above threshold for sigma^2 = %f: %f ≈ %f\n", sigma(i), percent(i), p(i));

end
