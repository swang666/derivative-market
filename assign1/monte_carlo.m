function [price, conf_int] = monte_carlo(N, T, S0, r, sigma, K)
    paths = zeros(100000, N+1);
    rnorm = randn(100000, N);
    payoff = zeros(100000, 2);
    dt = T/N;
    paths(:, 1) = S0;
    for i = 1:N
        paths(:,i+1) = paths(:, i).*exp( (r-sigma^2/2)*dt +  sigma* rnorm(:, i) * sqrt(dt));
    end
    payoff(:,1) = mean(paths, 2) - K;
    
    prices = max(payoff,[], 2);
    price = exp(-r*T)*mean(prices);
    conf_int = 1;

end