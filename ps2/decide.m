function [MAP, ML, like, post, p] = decide(r1, r2, b1, b2)   
    d1 = r1 + b1;
    d2 = r2 + b2 + 1;

    %       r1    b1 r2 b2
    p = [ r1/d1 b1/d1 0 0]; % probabilities

    %         r2 | r1   r2 | b1  b2 | r1   b2 | b1
    like = [ (r2+1)/d2  (r2)/d2  (b2)/d2  (b2+1)/d2 ]; % likelihoods

    p(3) = (like(1)*p(1) + like(2)*p(2));
    p(4) = (like(3)*p(1) + like(4)*p(2));

    %           r1 | r2            b1 | r2             r1 | b2         b1 | b2
    post = [ like(1)*p(1)/p(3)  like(2)*p(2)/p(3) like(3)*p(1)/p(4) like(4)*p(2)/p(4) ];

    % make the decisions
    MAP = [find(post(1:2) == max(post(1:2))) find(post(3:4) == max(post(3:4)))];
    ML = [find(like(1:2) == max(like(1:2))) find(like(3:4) == max(like(3:4)))];

end
