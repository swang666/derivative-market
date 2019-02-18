function [pr, payoff, delta, bond, opt] = american_option_dividend(S0, euro, type, K, r, h,u, d, T, D, div)
    periods = T;
    prices = zeros(periods+1, periods+1);
    payoffs = zeros(periods+1, periods +1);
    p_no = zeros(periods, periods);
    p_ex = zeros(periods, periods);
    del = zeros(periods, periods);
    b = zeros(periods, periods);
    opt_pos = [];
    for i = (periods+1):-1:1
        n = sum(D <= i);
        for j = 1: i
            prices(j,i) = S0 * u^(i-j)*d^(j-1)*(1 - div)^n;
            if i == periods+1
                %initialize final payoff
                if strcmp(type,'call')
                    payoffs(j,i) = max([prices(j,i)-K, 0]);
                elseif strcmp(type, 'put')
                    payoffs(j,i) = max([-prices(j,i)+K, 0]);
                elseif strcmp(type, 'straddle')
                    payoffs(j,i) = max([-prices(j,i)+K, prices(j,i)-K]);
                end
            else
                p_no(j,i) = exp(-r*h)* (payoffs(j,i+1)*(exp(r*h)-d)/(u-d) +payoffs(j+1,i+1)*(u-exp(r*h))/(u-d));
              
                if strcmp(type,'call')
                    p_ex(j,i) = max([prices(j,i)-K, 0]);
                elseif strcmp(type, 'put')
                    p_ex(j,i) = max([-prices(j,i)+K, 0]);
                elseif strcmp(type, 'straddle')
                    p_ex(j,i) = max([-prices(j,i)+K, prices(j,i)-K]);
                end
                if strcmp(euro, 'E')
                    payoffs(j,i) = p_no(j,i);
                else
                    payoffs(j,i) = max([p_no(j,i), p_ex(j,i)]);
                end
                if p_ex(j,i) > p_no(j,i)
                    opt_pos = [opt_pos; [j,i]];
                end
                del(j,i) = (payoffs(j, i+1) - payoffs(j+1,i+1))/(prices(j,i+1)-prices(j+1,i+1));
                b(j,i) = exp(-r*h) * (u * payoffs(j+1,i+1) - d*payoffs(j, i+1))/(u-d);
            end
        end
    end
    pr = prices;
    payoff = payoffs;
    delta = del;
    bond = b;
    opt = opt_pos;
end
