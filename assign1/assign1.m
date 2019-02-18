S0 = 100;
K = 90;
r = 0.02;
h = 0.25;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 4;

[prices, payoffs, delta, bond] = european_option(S0, 'straddle', K, r, h, u, d, T);
straddle_price = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 100;
K = 90;
r = 0.02;
h = 0.025;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 40;

[prices, payoffs, delta, bond] = european_option(S0, 'straddle', K, r, h, u, d, T);
straddle_price2 = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 100;
K = 90;
r = 0.02;
h = 0.25;
u = exp(r*h+0.2*sqrt(h));
d = exp(r*h-0.2*sqrt(h));
T = 4;

[prices, payoffs, delta, bond] = european_option(S0, 'binary', K, r, h, u, d, T);
binary_price = payoffs(1,1)
d = delta(1,1)
b = bond(1,1)

S0 = 10;
K = 10;
r = 0.01;
h = 1/365;
u = exp(r*h+0.15*sqrt(h));
d = exp(r*h-0.15*sqrt(h));
T = 250;

[prices, payoffs, delta, bond, opt] = american_option(S0, 'call', K, r, h, u, d, T);
American_call_price = payoffs(1,1)
del = delta(1,1)
bo = bond(1,1)
opt

[prices, payoffs, delta, bond, opt] = american_option(S0, 'put', K, r, h, u, d, T);
American_put_price = payoffs(1,1)

S0 = 10;
K = 10;
r = 0.02;
u = exp(0.2*sqrt(h));
d = 1/u;
h = 1/365;
T = 200;
div = 0.05;
D = [50, 100, 150];
[prices, payoffs, delta, bond, opt] = american_option_dividend(S0, 'A', 'call', K, r, h,u, d, T, D, div);
American_call_with_div = payoffs(1,1)

[prices, payoffs, delta, bond, opt] = american_option_dividend(S0, 'A', 'put', K, r, h,u, d, T, D, div);
American_put_with_div = payoffs(1,1)

[prices, payoffs, delta, bond, opt] = american_option_dividend(S0, 'A', 'straddle', K, r, h,u, d, T, D, div);
American_straddle_with_div = payoffs(1,1)

S0 = 200;
r = 0.02;
sigma = 0.2;
K = 220;
T = 1;
N = 365;
[price, int] = monte_carlo(N, T, S0, r, sigma, K);
price
%%
N = 250;
S0 = 200;
r = 0.1;
sigma = 0.3;
K = 220;
T = 1;
num = 10000;

[p, cf, paths, cont, dis] = Longstaff(N, T, K, S0, r, sigma, num);
longstaff_price = p


