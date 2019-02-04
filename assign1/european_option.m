function [pr, pay, delta, bond] = european_option(S0, type, K, r, h,u, d, T)
    periods = T;
    prices = zeros(periods+1, periods+1);
    payoffs = zeros(periods+1, periods +1);
    del = zeros(periods, periods);
    b = zeros(periods, periods);
    for i = (periods+1):-1:1
        for j = 1: i
            prices(j,i) = S0 * u^(i-j)*d^(j-1);
            if i == periods+1
                %initialize final payoff
                if strcmp(type,'straddle')
                    A = [prices(j,i)-K, K- prices(j,i)];
                    payoffs(j,i) = max(A);
                elseif strcmp(type, 'binary')
                    if (prices(j,i) -K) > 0
                        payoffs(j,i) = 1;
                    else
                        payoffs(j,i) = 0;
                    end
                end
            else
                payoffs(j,i) = exp(-r*h)* (payoffs(j,i+1)*(exp(r*h)-d)/(u-d) +payoffs(j+1,i+1)*(u-exp(r*h))/(u-d));
                del(j,i) = (payoffs(j, i+1) - payoffs(j+1,i+1))/(prices(j,i+1)-prices(j+1,i+1));
                b(j,i) = exp(-r*h) * (u * payoffs(j+1,i+1) - d*payoffs(j, i+1))/(u-d);
            end
        end
    end
    pr = prices;
    pay = payoffs;
    delta = del;
    bond = b;
end
