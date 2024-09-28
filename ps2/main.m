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

            fprintf('Case %s:\n', num2str(i));
            disp(['  MAP:  ', num2str(MAP(i, 1)), ' (', num2str(MAP_err(i, 1)), '), ', num2str(MAP(i, 2)), ' (', num2str(MAP_err(i, 2)), ')']);
            disp(['  ML:   ', num2str(ML(i, 1)), ' (', num2str(ML_err(i, 1)), '), ', num2str(ML(i, 2)), ' (', num2str(ML_err(i, 2)), ')']);
            fprintf('\n  Post: %s \n', num2str(post));
            fprintf('  Like: %s \n\n', num2str(like));
        end

        [outcome_1, ball] = bingo(r1, b1);
        [outcome_2, mask] = bingo(r2 + ball(1), b2 + ball(2)); 
        comp = ones([1,2])*outcome_1 .* mask;
        comp_map = mask .* MAP(i, :);
        comp_ml = mask .* ML(i,:);

        %fprintf('  color %d | comp [%s] | ml [%s] | map [%s]\n-----------------\n\n', outcome_1, num2str(comp), num2str(comp_ml), num2str(comp_map));

        accurate(i, 1) = accurate(i, 1) + (sum(comp) == sum(comp_map));
        accurate(i, 2) = accurate(i, 2) + (sum(comp) == sum(comp_ml));
    end        
end

accurate = 1-accurate/N
err = [sum(MAP_err, 2) sum(ML_err, 2)]
