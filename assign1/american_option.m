function [pr, pay, delta, bond, opt] = american_option(S0, type, K, r, h,u, d, T)
    periods = T;
    prices = zeros(periods+1, periods+1);
    payoffs = zeros(periods+1, periods +1);
    p_no = zeros(periods, periods);
    p_ex = zeros(periods, periods);
    del = zeros(periods, periods);
    b = zeros(periods, periods);
    opt_pos = [];
    for i = (periods+1):-1:1
        for j = 1: i
            prices(j,i) = S0 * u^(i-j)*d^(j-1);
            if i == periods+1
                %initialize final payoff
                if strcmp(type,'call')
                    if (prices(j,i) -K) > 0
                        payoffs(j,i) = 1;
                    else
                        payoffs(j,i) = 0;
                    end
                elseif strcmp(type, 'put')
                    if (prices(j,i) -K) < 0
                        payoffs(j,i) = 1;
                    else
                        payoffs(j,i) = 0;
                    end
                end
            else
                p_no(j,i) = exp(-r*h)* (payoffs(j,i+1)*(exp(r*h)-d)/(u-d) +payoffs(j+1,i+1)*(u-exp(r*h))/(u-d));
                
                if strcmp(type,'call')
                    if (prices(j,i) -K) > 0
                        p_ex(j,i) = 1;
                    else
                        p_ex(j,i) = 0;
                    end
                elseif strcmp(type, 'put')
                    if (prices(j,i) -K) < 0
                        p_ex(j,i) = 1;
                    else
                        p_ex(j,i) = 0;
                    end
                end
                payoffs(j,i) = max([p_no(j,i), p_ex(j,i)]);
                if p_ex(j,i) > p_no(j,i)
                    opt_pos = [opt_pos; [j,i]];
                end
                del(j,i) = (payoffs(j, i+1) - payoffs(j+1,i+1))/(prices(j,i+1)-prices(j+1,i+1));
                b(j,i) = exp(-r*h) * (u * payoffs(j+1,i+1) - d*payoffs(j, i+1))/(u-d);
            end
        end
    end
    pr = prices;
    pay = payoffs;
    delta = del;
    bond = b;
    opt = opt_pos;
end
