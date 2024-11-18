clc;
clear;
close all;

format long;

%% Question 1A

p = [24 18 15 21 07 06 05 04] / 100;
l = ceil(-1*log2(p));

kraft = sum(2.^(-1*l));

%% Question 1B

h = sum(-p.*log2(p));
L = sum(l.*p);

fprintf('Question 1\n');
fprintf('  [A]: %f <= 1\n', kraft);
fprintf('  [B]: H = %f\n       L = %f\n\n', h, L);

%% Question 2
l_2 = [2 2 3 3 4 4 4 4];
L_2 = sum(l_2.*p);
kraft_2 = sum(2.^(-1*l_2));

fprintf('Question 2\n');
fprintf('  Kraft Inequality: %f <= 1\n', kraft_2);
fprintf('  Average Length:   %f\n\n', L_2);

code = [
            p(1) * sum(p(1:3)) % 00 0
            p(1) * sum(p(4:8)) % 00 1
            p(2)               % 010
            p(3)               % 011
            p(4) * sum(p(1:3)) % 10 0
            p(4) * sum(p(4:8)) % 10 1
            p(5) + p(6)        % 110
            p(7) + p(8)        % 111
        ];
           

%% Question 3
p_y3 = [sum(code(1:2:7)) sum(code(2:2:8))];         % [y3 = 0 y3 = 1]
p_y2 = [sum(code([1 2 5 6])) sum(code([3 4 7 8]))]; % [y2 = 0 y2 = 1]
p_y1y2 = [sum(code([1 2])) sum(code([3 4])) sum(code([5 6])) sum(code([7 8]))];


% joint probabilities of 00 01 10 11
joint_2 = [sum(code([1 5])) sum(code([3 7])) sum(code([2 6])) sum(code([4 8]))];

% H(y3)
h_3 = sum(-p_y3.*log2(p_y3));
% H(y_3 | y2)
h_3g2 = sum(-joint_2.*log2([joint_2(1)/p_y2(1) joint_2(2)/p_y2(2) joint_2(3)/p_y2(1) joint_2(4)/p_y2(2)]));
% H(y_3 | y2 y1)
h_3g2g1 = sum(-(code').*log2((code')./p_y1y2([1 1 2 2 3 3 4 4])));

fprintf('Question 3\n');
fprintf('  H(Y_3)           = %f\n', h_3);
fprintf('  H(Y_3 | Y_2)     = %f\n', h_3g2);
fprintf('  H(Y_3 | Y_2 Y_1) = %f\n\n', h_3g2g1);

%% Question 4
phi = @(p) (-p.*log(p) - (ones(size(p))-p).*log(ones(size(p))-p));

p = linspace(.01, .49, 100);
pio = ((exp((phi(p) - phi(2*p)) ./ (ones(size(p)) - 3*p)) + ones(size(p))) .^-1 ...
         - 2*p) ./ (ones(size(p)) - 3*p);

I = pio.*phi(p) - (ones(size(p))-pio).*phi(2*p) + phi(pio + 2*p - 3*p.*pio);

c = I/log(2);

figure;
plot(p, c);
xlabel("Probability");
ylabel("Capacity");
title("Capacity vs Probability");

figure;
plot(p, pio);
xlabel("Probability");
ylabel("Pio");
title("Optimal Pio vs Probability");

%% Question 5
lamda = .01:.001:1;
sigma = [1 .8 .1 .01];
D = zeros(size(lamda));
R = zeros(size(lamda));

for i = 1:length(lamda)
    d = (lamda(i) <= sigma).*lamda(i) + (lamda(i) > sigma).*sigma;
    D(i) = sum(d);
    R(i) = sum(log2(sigma./d)/2);
end
R = R.*(R <= 5);
[~, index] = min(5-R);

fprintf("Question 5\n");
fprintf("  D     = %f\n", D(index));
fprintf("  R     = %f\n", R(index));
fprintf("  lamda = %f\n\n", lamda(index));




%% Question 6

N = 1e-8;
B = 1e6;
C = 1e6;

syms P

eqn = C == B*log2(1+P/(N*B));

sol = solve(eqn, P);
fprintf('Question 6\n  Power = %f Watts\n\n', sol);
