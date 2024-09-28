function [color, v] = bingo(r, b)
    ballno = randi(r + b);

    color = (ballno <= r)*1 + (~(ballno <=r))*2;
    v = (ballno <= r)*[1 0] + (~(ballno <=r))*[0 1];
end
