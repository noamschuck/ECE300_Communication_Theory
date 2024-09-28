function err = get_error(decision, like, p)
    err = [0 0];

    % rx red,     if tx = blue                        else if tx = red
    err(1) = (decision(1)==2)*(like(1)*p(1)) + (~(decision(1)==2))*(like(2)*p(2)); 

    % rx blue,     if tx = blue                      else if tx = red
    err(2) = (decision(2)==2)*(like(3)*p(1)) + (~(decision(2)==2))*(like(4)*p(2));
end
