clc;
clear;
close all;

cases = [ 2 8 2 8;
          6 4 2 8;
          2 8 6 4;
          6 4 6 4; ];

MAP = zeros([4, 2]);
ML = zeros([4, 2]);
MAP_err = zeros([4, 2]);
ML_err  = zeros([4, 2]);

accurate = zeros([4, 2]); % first col is MAP second is ML
N = 1e5;

for n = 1 : N
    for i = 1:size(cases,1)
        b1 = cases(i, 1);
        r1 = cases(i, 2);
        b2 = cases(i, 3);
        r2 = cases(i, 4);
        
        if( n == 1 )
            [MAP(i, :), ML(i, :), like, post, p] = decide(r1, r2, b1, b2);
            MAP_err(i, :) = get_error(MAP(i, :), like, p);
            ML_err(i, :) = get_error(ML(i, :), like, p);
        end

        [outcome_1, ball] = bingo(r1, b1);
        [outcome_2, mask] = bingo(r2 + ball(1), b2 + ball(2)); 
        comp = ones([1,2])*outcome_1 .* mask;

        accurate(i, 1) = accurate(i, 1) + (sum(comp) == sum(mask .* MAP(i, :)));
        accurate(i, 2) = accurate(i, 2) + (sum(comp) == sum(mask .* ML(i,:)));
    end        
end

experimental = 1-accurate/N;
theoretical = [sum(MAP_err, 2) sum(ML_err, 2)];
